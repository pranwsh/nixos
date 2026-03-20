{...}: {
  programs.nvf.settings = {
    vim = {
      languages = {
        rust = {
          enable = true;
          lsp.enable = true;
          treesitter.enable = true;
          dap.enable = true;
        };
      };
    };
  };
}
