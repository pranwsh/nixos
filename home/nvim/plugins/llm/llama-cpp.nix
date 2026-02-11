{
  config,
  pkgs,
  lib,
  ...
}: let
  qwen-model = pkgs.fetchurl {
    url = "https://huggingface.co/Qwen/Qwen2.5-Coder-7B-Instruct-GGUF/resolve/main/qwen2.5-coder-7b-instruct-q4_k_m.gguf";
    hash = "sha256-UJKH94y01M9rOENzRzO5FLLBWOQ+Iqf0v16WOACJTTw=";
  };

  # Build llama-cpp with ROCm support (compiles from source, takes time)
  llama-cpp-rocm = pkgs.llama-cpp.override {
    rocmSupport = true;
  };
in {
  # 1. Ensure kernel drivers are loaded
  boot.initrd.kernelModules = ["amdgpu"];
  services.xserver.videoDrivers = ["amdgpu"];

  # 2. Configure Graphics & Compute
  # Note: 'hardware.graphics' replaced 'hardware.opengl' in 24.11/unstable
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      # The Common Language Runtime (CLR) replaces old OpenCL packages
      rocmPackages.clr
      rocmPackages.clr.icd

      # Helpful tools for debugging (optional but recommended)
      rocmPackages.rocminfo
      clinfo
    ];
  };

  # 3. Environment Variables
  home.sessionVariables = {
    # Helps llama.cpp find the GPU if it defaults to CPU
    # Adjust "gfx1030" to match your specific GPU (use 'rocminfo' to find it)
    HSA_OVERRIDE_GFX_VERSION = "10.3.0";
  };

  # 4. The Service
  systemd.user.services.qwen-coder = {
    Unit = {
      Description = "Qwen2.5-Coder 7B LLM Server";
      After = ["network.target"];
    };
    Service = {
      Type = "simple";
      # Added --n-gpu-layers 99 to ensure full offloading if VRAM allows
      ExecStart = "${llama-cpp-rocm}/bin/llama-server --model ${qwen-model} --host 127.0.0.1 --port 8080 --ctx-size 4096 --n-gpu-layers 99";
      Restart = "on-failure";
      RestartSec = 5;
    };
    Install = {
      WantedBy = ["default.target"];
    };
  };
}
