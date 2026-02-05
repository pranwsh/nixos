{...}: {
  programs.nvf.settings = {
    vim = {
      # Global LSP settings
      lsp = {
        enable = true; # Replaces languages.enableLSP
        formatOnSave = true;
      };
      # Language-specific modules
      languages = {
        # Note: enableLSP removed here as it is now vim.lsp.enable
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
      };
      # FIX: Warning regarding nvimWebDevicons rename
      visuals = {
        nvim-web-devicons.enable = true;
      };
    };
  };
}
