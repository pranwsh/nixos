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

  # Inject the API key at runtime via shell alias
  home.shellAliases = {
    openclaude = "DEEPSEEK_API_KEY=$(pass show apis/deepseek) openclaude";
  };
}
