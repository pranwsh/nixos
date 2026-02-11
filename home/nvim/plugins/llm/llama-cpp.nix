# /home/nvim/plugins/llm/llama-cpp.nix
{pkgs, ...}: let
  qwen-model = pkgs.fetchurl {
    url = "https://huggingface.co/Qwen/Qwen2.5-Coder-7B-Instruct-GGUF/resolve/main/qwen2.5-coder-7b-instruct-q4_k_m.gguf";
    hash = "sha256-UJKH94y01M9rOENzRzO5FLLBWOQ+Iqf0v16WOACJTTw=";
  };

  # Compile llama-cpp with ROCm support
  llama-cpp-rocm = pkgs.llama-cpp.override {
    rocmSupport = true;
  };
in {
  # 1. Environment Variables
  home.sessionVariables = {
    # Helps llama.cpp find the GPU.
    # Use 'rocminfo' to check your specific GFX version if 10.3.0 doesn't work.
    HSA_OVERRIDE_GFX_VERSION = "10.3.0";
  };

  # 2. The User Service
  systemd.user.services.qwen-coder = {
    Unit = {
      Description = "Qwen2.5-Coder 7B LLM Server";
      After = ["network.target"];
    };
    Service = {
      Type = "simple";
      # Note the --n-gpu-layers 99 flag to force GPU usage
      ExecStart = "${llama-cpp-rocm}/bin/llama-server --model ${qwen-model} --host 127.0.0.1 --port 8080 --ctx-size 4096 --n-gpu-layers 99";
      Restart = "on-failure";
      RestartSec = 5;
    };
    Install = {
      WantedBy = ["default.target"];
    };
  };
}
