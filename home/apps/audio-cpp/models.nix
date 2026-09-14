{ pkgs, lib, ... }:

let
  # Helper: fetch a single Hugging Face file with a fixed hash.
  mkFile =
    repo: file:
    {
      name = file.path;
      src = pkgs.fetchurl {
        url = "https://huggingface.co/${repo}/resolve/main/${file.path}";
        hash = file.hash;
        name = baseNameOf file.path;
      };
    };

  # Helper: assemble a Hugging Face model package into the directory layout
  # audio.cpp expects, preserving relative paths such as sidecars/.
  # Also carries the server metadata so default.nix can expose every
  # declared model in the generated server config generically.
  mkPackage =
    {
      repo,
      targetDirectory,
      files,
      id,
      family,
      task,
      mode ? "offline",
      # Main GGUF relative to the package root. The CLI/server must be
      # pointed at this single file: a directory holding both the main
      # and VAE GGUFs is rejected as ambiguous. VAE and sidecars resolve
      # relative to the file's parent directory.
      mainFile,
    }:
    {
      path = pkgs.runCommand "audiocpp-${targetDirectory}" { }
        ''
          mkdir -p $out
          ${lib.concatMapStrings (file: ''
            mkdir -p "$out/$(dirname "${file.name}")"
            ln -s ${file.src} "$out/${file.name}"
          '') (map (mkFile repo) files)}
        '';
      inherit mainFile;
      server = {
        inherit id family task mode;
      };
    };

in
{
  yue2-3b-q8_0 = mkPackage {
    repo = "audio-cpp/Yue2-3B-GGUF";
    targetDirectory = "Yue2-3B-GGUF";
    id = "yue2";
    family = "yue2";
    task = "gen";
    mainFile = "yue2-3b-q8_0.gguf";
    files = [
      {
        path = "yue2-3b-q8_0.gguf";
        hash = "sha256-86njsZe/0Fqkrmqy1Lk/bVfIzA6jmkr30VH1hpfHz7Y=";
      }
      {
        path = "yue2-vae-f16.gguf";
        hash = "sha256-1PSgXY8pGuggzR5DYJ2j+pG1ZGWBAJGisIwzULdRcZ0=";
      }
      {
        path = "sidecars/yue2-model-config.json";
        hash = "sha256-rTR3u++JC/mK4ZbB5LRHeUlKYjHEq2bzJwjqut8mUyk=";
      }
      {
        path = "sidecars/yue2-generation-config.json";
        hash = "sha256-IDgwzr3m42ROspGSU2KZDRmOZsO2AGzRHxqqIZBLzGE=";
      }
      {
        path = "sidecars/yue2-qwen.tiktoken";
        hash = "sha256-srG437XMXwJLr8NzEhxquj9m+aWgJp4kNHCh3hajMYY=";
      }
      {
        path = "sidecars/yue2-vae-config.json";
        hash = "sha256-8BkbuWlACZVt5E4MNhpvEzR2C+TI+Ejlmb3iQqVKCXA=";
      }
    ];
  };

  yue2-3b-q4_0 = mkPackage {
    repo = "audio-cpp/Yue2-3B-GGUF";
    targetDirectory = "Yue2-3B-GGUF-q4_0";
    id = "yue2-q4_0";
    family = "yue2";
    task = "gen";
    mainFile = "yue2-3b-q4_0.gguf";
    files = [
      {
        path = "yue2-3b-q4_0.gguf";
        hash = "sha256-l69n1/gAs2L67m5r7IBr3fzMuT8l/T+aEBJyTZWvb0o=";
      }
      {
        path = "yue2-vae-f16.gguf";
        hash = "sha256-1PSgXY8pGuggzR5DYJ2j+pG1ZGWBAJGisIwzULdRcZ0=";
      }
      {
        path = "sidecars/yue2-model-config.json";
        hash = "sha256-rTR3u++JC/mK4ZbB5LRHeUlKYjHEq2bzJwjqut8mUyk=";
      }
      {
        path = "sidecars/yue2-generation-config.json";
        hash = "sha256-IDgwzr3m42ROspGSU2KZDRmOZsO2AGzRHxqqIZBLzGE=";
      }
      {
        path = "sidecars/yue2-qwen.tiktoken";
        hash = "sha256-srG437XMXwJLr8NzEhxquj9m+aWgJp4kNHCh3hajMYY=";
      }
      {
        path = "sidecars/yue2-vae-config.json";
        hash = "sha256-8BkbuWlACZVt5E4MNhpvEzR2C+TI+Ejlmb3iQqVKCXA=";
      }
    ];
  };
}
