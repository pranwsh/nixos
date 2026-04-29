{ pkgs, ... }:

let
  # Import the model library
  models = import ./models.nix { pkgs = pkgs; };

  activeModel = models.qwen3-5-9b;

  contextSize = 8192;
  gpuLayers = 32; # Set to 0 for CPU-only
  systemPrompt = "You are a helpful coding assistant.";

  # Build llama.cpp with Vulkan
  llama-cpp-vulkan = pkgs.llama-cpp.override {
    vulkanSupport = true;
  };

  # Construct common arguments
  commonArgs = "-m ${activeModel.path} -c ${toString contextSize} -ngl ${toString gpuLayers}";

in
{
  home.packages = [
    llama-cpp-vulkan
  ];

  programs.fish.functions = {
    ai-chat = {
      body = ''
        llama-cli ${commonArgs} \
          -p "${systemPrompt}" \
          -cnv \
          --color auto
      '';
    };
  };
}
