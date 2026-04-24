# ai-config.nix
{ pkgs, ... }:

let
  # Import the model library
  models = import ./models.nix { pkgs = pkgs; };

  # ==============================================================================
  # 🎯 ACTIVE MODEL SELECTION
  # Change this variable to switch models instantly.
  # Options: models.gemma2-9b, models.qwen2.5-coder-7b, etc.
  # ==============================================================================

  activeModel = models.qwen3-5-9b;

  # ==============================================================================
  # ⚙️ RUNTIME SETTINGS
  # ==============================================================================

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
