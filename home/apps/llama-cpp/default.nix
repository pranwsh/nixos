{
  pkgs,
  ...
}:
let
  # Gemma 2 9B It (Q4_K_M)
  modelName = "gemma-2-9b-it-Q4_K_M.gguf";
  modelUrl = "https://huggingface.co/bartowski/gemma-2-9b-it-GGUF/resolve/main/${modelName}";

  gemmaModel = pkgs.fetchurl {
    url = modelUrl;
    sha256 = "sha256-E7KntBFbvQkAFi7c6+R22huh/CTnGOi0DTL24wD1bf4=";
    name = modelName;
  };

  # Llama.cpp with Vulkan support
  llama-cpp-vulkan = pkgs.llama-cpp.override {
    vulkanSupport = true;
  };
in
{
  home.packages = [
    llama-cpp-vulkan
  ];

  home.shellAliases = {
    # -ngl 33 offloads layers to the GPU via Vulkan
    gemma = "llama-cli -m ${gemmaModel} -c 8192 -p 'You are a helpful assistant.' -cnv -ngl 33";

    # Server mode with Vulkan support
    gemma-server = "llama-server -m ${gemmaModel} -c 8192 --port 8080 -ngl 33";
  };
}
