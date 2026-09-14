{ pkgs, ... }:
{
  home.packages = [
    pkgs.opencode
  ];
  home.file.".config/opencode/opencode.json".text = builtins.toJSON {
    "$schema" = "https://opencode.ai/config.json";
    model = "inferx/deepseek-v4.1-flash";
    theme = "system";
    provider = {
      mistral = {
        options = {
          apiKey = "{file:/run/secrets/mistral_key}";
        };
      };
      nvidia = {
        options = {
          apiKey = "{file:/run/secrets/nvidia_key}";
        };
      };
      tokenrouter = {
        options = {
          apiKey = "{file:/run/secrets/tokenrouter_key}";
        };
      };
      inferx = {
        npm = "@ai-sdk/openai-compatible";
        name = "InferX";
        options = {
          apiKey = "{file:/run/secrets/inferx_key}";
          baseURL = "https://model.inferx.net/endpoints/v1";
        };
        models = {
          "deepseek-v4.1-flash" = {
            name = "DeepSeek V4.1 Flash";
            tool_call = true;
            limit = {
              context = 1000000;
              output = 128000;
            };
          };
        };
      };
      llama-cpp = {
        npm = "@ai-sdk/openai-compatible";
        name = "llama-server (local)";
        options = {
          baseURL = "http://127.0.0.1:8080/v1";
        };
        models = {
          bonsai-27b = {
            name = "Bonsai 27B (local)";
            # limit = {
            #   context = 8192;
            #   output = 2048;
            # };
          };
        };
      };
    };
  };
}
