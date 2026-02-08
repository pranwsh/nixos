{pkgs, ...}: {
  # 1. Declaratively manage the Ollama Daemon and Models
  services.ollama = {
    enable = true;
    acceleration = "cuda"; # Or "rocm" for AMD, or null for CPU
    loadModels = ["qwen2.5-coder:7b"]; # Nix will pull this on rebuild
  };

  # 2. NVF Configuration
  # Place this inside your existing nvf.configuration.vim block
  programs.nvf.settings.vim = {
    extraPlugins = with pkgs.vimPlugins; {
      dressing = {package = dressing-nvim;};
      nui = {package = nui-nvim;};
      plenary = {package = plenary-nvim;};

      avante = {
        package = avante-nvim;
        setup = "require('avante').setup";
        setupOpts = {
          provider = "ollama";
          auto_suggestions_provider = "ollama";
          ollama = {
            endpoint = "http://127.0.0.1:11434";
            model = "qwen2.5-coder:7b";
            temperature = 0;
            max_tokens = 4096;
          };
          behaviour = {
            auto_suggestions = true;
            auto_set_keymaps = true;
          };
        };
      };
    };

    # Ensure system tools are available to the editor
    extraPackages = with pkgs; [
      curl
      git
      ripgrep
    ];
  };
}
