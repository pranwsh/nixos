{ pkgs, ... }:
{
  home.packages = [
    pkgs.opencode
  ];
  home.file.".config/opencode/opencode.json".text = builtins.toJSON {
    "$schema" = "https://opencode.ai/config.json";
    model = "empero/glm-5.3-flash";
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
      llama-cpp = {
        npm = "@ai-sdk/openai-compatible";
        name = "llama-server (local)";
        options = {
          baseURL = "http://127.0.0.1:8080/v1";
        };
        models = {
          bonsai-27b = {
            name = "Bonsai 27B (local)";
            limit = {
              context = 8192;
              output = 2048;
            };
          };
        };
      };

      empero = {
        npm = "@ai-sdk/openai-compatible";
        name = "empero";
        options = {
          baseURL = "https://free.empero.org/v1";
          apiKey = "free";
        };
        models = {
          "glm-5.3-flash" = {
            name = "GLM 5.3 Flash";
          };
        };
      };
    };
  };
}
