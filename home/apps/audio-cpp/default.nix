{ pkgs, inputs, lib, ... }:

let
  # Import the model library
  models = import ./models.nix { inherit pkgs lib; };

  activeModel = models.yue2-3b-q4_0;

  # Single GGUF file to pass via --model; the VAE and sidecars resolve
  # relative to its parent directory.
  activeModelFile = "${activeModel.path}/${activeModel.mainFile}";

  backend = "vulkan";
  threadsCli = 4;
  threadsServer = 1;

  # Low-VRAM tuning for AMD Barcelo iGPU (14GB shared RAM).
  # NOTE: audio.cpp has no n_ubatch/ubatch flag (verified via
  # `audiocpp_cli --help` + `--help --family yue2` + binary strings).
  # These supported session arenas + Q4 weights are the equivalent lever:
  # smaller prefill/NAR graphs = smaller single Vulkan submissions,
  # which is what `llama.cpp -ub 128` achieves for LLMs.
  # Single source of truth, mirrored to CLI + server like
  # llama-cpp's `microBatch`/`commonArgs` pattern.
  yue2Tune = {
    vae_gguf = "yue2-vae-f16.gguf";
    model_weight_type = "q4_0";
    vae_weight_type = "f16";
    model_weight_context_mb = 3072;
    vae_weight_context_mb = 1024;
    ar_prefill_graph_arena_mb = 2048;
    ar_decode_graph_arena_mb = 1024;
    nar_graph_arena_mb = 3072;
    vae_graph_arena_mb = 1024;
    num_inference_steps = 8;
  };

  # Session options shared by CLI (--session-option) and server JSON
  # (models[].session_options). Keys must stay in yue2.* namespace.
  yue2SessionOptions = {
    # Always resolves inside the active package dir (select_component_assets
    # rejects absolute paths and missing files).
    "yue2.model_gguf" = activeModel.mainFile;
    "yue2.vae_gguf" = yue2Tune.vae_gguf;
    "yue2.model_weight_type" = yue2Tune.model_weight_type;
    "yue2.vae_weight_type" = yue2Tune.vae_weight_type;
    "yue2.model_weight_context_mb" = yue2Tune.model_weight_context_mb;
    "yue2.vae_weight_context_mb" = yue2Tune.vae_weight_context_mb;
    "yue2.ar_prefill_graph_arena_mb" = yue2Tune.ar_prefill_graph_arena_mb;
    "yue2.ar_decode_graph_arena_mb" = yue2Tune.ar_decode_graph_arena_mb;
    "yue2.nar_graph_arena_mb" = yue2Tune.nar_graph_arena_mb;
    "yue2.vae_graph_arena_mb" = yue2Tune.vae_graph_arena_mb;
  };

  # CLI fragment reused by audio-music / audio-music-cpu.
  yue2SessionCliArgs = lib.concatStringsSep " \\\n          " (
    lib.mapAttrsToList (k: v: "--session-option ${k}=${toString v}") yue2SessionOptions
  );

  # Server model entries derived from every declared model, so adding a
  # model to models.nix automatically exposes it in the WebUI.
  # Yue2 entries get the low-VRAM session_options; other families pass through.
  # NOTE: yue2.model_gguf must point at a file inside that entry's own
  # package dir, so it is set per-model from mainFile (the shared yue2Tune
  # value only matches the q4_0 active package).
  serverModels = lib.mapAttrsToList (
    _name: model:
    model.server
    // {
      path = "${model.path}/${model.mainFile}";
    }
    // lib.optionalAttrs (model.server.family == "yue2") {
      session_options = yue2SessionOptions // {
        "yue2.model_gguf" = model.mainFile;
      };
    }
  ) models;

  # Server config exposing all declared models.
  # The WebUI runs in configured-model mode (no --ui-management), which
  # lists exactly these models with their store paths.
  serverConfig = pkgs.writeText "audiocpp-server.json" (builtins.toJSON {
    host = "127.0.0.1";
    port = 8080;
    backend = backend;
    threads = threadsServer;
    models = serverModels;
  });

in
{
  home.packages = [
    inputs.audiocpp.packages.${pkgs.stdenv.hostPlatform.system}.vulkan
  ];

  programs.fish.functions = {
    audio-music = {
      body = ''
        if test (count $argv) -lt 2
          echo "usage: audio-music <style> <lyrics> [out.wav]"
          return 1
        end
        set -l style $argv[1]
        set -l lyrics $argv[2]
        set -l out yue2.wav
        if test (count $argv) -ge 3
          set out $argv[3]
        end
        set -lx GGML_VK_MAX_NODES_PER_SUBMIT 16
        audiocpp_cli \
          --task gen \
          --family yue2 \
          --model ${activeModelFile} \
          --backend ${backend} \
          --threads ${toString threadsCli} \
          ${yue2SessionCliArgs} \
          --lyrics "$lyrics" \
          --request-option style="$style" \
          --request-option cot=off \
          --request-option num_inference_steps=${toString yue2Tune.num_inference_steps} \
          --seed 831001 \
          --out "$out" \
          --log --metrics
      '';
    };

    # CPU fallback: guaranteed to dodge Vulkan `context lost` driver resets
    # on the Barcelo iGPU at the cost of speed. Same session tuning.
    audio-music-cpu = {
      body = ''
        if test (count $argv) -lt 2
          echo "usage: audio-music-cpu <style> <lyrics> [out.wav]"
          return 1
        end
        set -l style $argv[1]
        set -l lyrics $argv[2]
        set -l out yue2-cpu.wav
        if test (count $argv) -ge 3
          set out $argv[3]
        end
        audiocpp_cli \
          --task gen \
          --family yue2 \
          --model ${activeModelFile} \
          --backend cpu \
          --threads ${toString threadsCli} \
          ${yue2SessionCliArgs} \
          --lyrics "$lyrics" \
          --request-option style="$style" \
          --request-option cot=off \
          --request-option num_inference_steps=${toString yue2Tune.num_inference_steps} \
          --seed 831001 \
          --out "$out" \
          --log --metrics
      '';
    };

    audio-serve = {
      body = ''
        set -lx GGML_VK_MAX_NODES_PER_SUBMIT 16
        audiocpp_server \
          --config ${serverConfig} \
          --backend ${backend} \
          --threads ${toString threadsServer} \
          --ui \
          $argv
      '';
    };
  };
}
