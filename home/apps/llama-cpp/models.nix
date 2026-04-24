# models.nix
{ pkgs, ... }:

let
  # Helper function to reduce repetition
  mkModel =
    {
      repo,
      file,
      sha256,
      name ? file,
    }:
    {
      name = name;
      path = pkgs.fetchurl {
        url = "https://huggingface.co/${repo}/resolve/main/${file}";
        sha256 = sha256;
        name = file;
      };
    };

in
{
  # ==============================================================================
  # 📚 MODEL LIBRARY
  # Add new models here. They will be downloaded but not necessarily active.
  # ==============================================================================

  gemma2-9b = mkModel {
    repo = "bartowski/gemma-2-9b-it-GGUF";
    file = "gemma-2-9b-it-Q4_K_M.gguf";
    sha256 = "sha256-E7KntBFbvQkAFi7c6+R22huh/CTnGOi0DTL24wD1bf4=";
  };

  # Qwen3.5-9B (March 2026) - Best all-rounder under 9B
  # Uses Q4_K_M quantization for optimal performance/size balance
  qwen3-5-9b = mkModel {
    repo = "unsloth/Qwen3.5-9B-GGUF";
    file = "Qwen3.5-9B-Q4_K_M.gguf";
    # ⚠️ REPLACE WITH ACTUAL HASH AFTER FIRST RUN IF EMPTY
    sha256 = "sha256-A7dHJ6hgpWM44ELEQguz8Esv7Fc0F19MufqFPa9St+g=";
  };

  # Example: Llama 3 8B (Uncomment to add)
  # llama3-8b = mkModel {
  #   repo = "bartowski/Meta-Llama-3-8B-Instruct-GGUF";
  #   file = "Meta-Llama-3-8B-Instruct-Q4_K_M.gguf";
  #   sha256 = "sha256-...";
  # };
}
