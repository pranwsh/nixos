{ pkgs, ... }:
{
  home.packages = [
    pkgs.opencode
  ];
  home.file.".config/opencode/opencode.json".text = builtins.toJSON {
    "$schema" = "https://opencode.ai/config.json";
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

      ninerouter = {
        npm = "@ai-sdk/openai-compatible";
        name = "9router";
        options = {
          apiKey = "sk-cdad3cb1abd9fc0b-ust4ab-f4a4aff6";
          baseURL = "http://localhost:20128/v1";
        };
        models = {
          "oc/muse-spark-1.3-contributor-free" = {
            name = "9router-muse-1.3";
            tool_call = true;
            limit = {
              context = 1000000;
              output = 512000;
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
