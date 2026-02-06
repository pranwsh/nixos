{...}: {
  programs.nvf.settings = {
    vim = {
      # Global LSP settings
      lsp = {
        enable = true;
        formatOnSave = true;
      };

      # Treesitter configuration
      treesitter = {
        enable = true;
        indent.enable = true;
      };

      # Language-specific modules
      languages = {
        enableTreesitter = true;
        enableFormat = true;

        # C/C++ Setup (Clangd)
        clang = {
          enable = true;
          lsp.enable = true;
          treesitter.enable = true;
          dap.enable = true;
        };

        # Nix Setup
        nix = {
          enable = true;
          lsp.enable = true;
          lsp.servers = ["nil"];
          format.enable = true;
          format.type = ["alejandra"];
        };

        # Assembly Setup
        assembly = {
          enable = true;
          lsp.enable = true;
          treesitter.enable = true;
        };
      };

      # FIX: Warning regarding nvimWebDevicons rename
      visuals = {
        nvim-web-devicons.enable = true;
      };
    };
  };
}
