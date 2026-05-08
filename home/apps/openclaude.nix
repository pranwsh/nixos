{ inputs, pkgs, ... }: {
  imports = [ inputs.openclaude.homeManagerModules.default ];

  programs.openclaude = {
    enable = true;
    settings = {
      agentModels = {
        "deepseek-chat" = {
          base_url = "https://api.deepseek.com/v1";
        };
      };
      agentRouting = {
        "Explore" = "deepseek-chat";
        "Plan" = "deepseek-chat";
        "default" = "deepseek-chat";
      };
    };
  };

  # Inject the API key and provider routing at runtime via shell alias
  home.shellAliases = {
    openclaude = "CLAUDE_CODE_USE_OPENAI=1 OPENAI_BASE_URL=https://api.deepseek.com/v1 OPENAI_API_KEY=$(pass show apis/deepseek) OPENAI_MODEL=deepseek-chat command openclaude";
  };
}
