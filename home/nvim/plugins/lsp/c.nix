{...}: {
  programs.nvf.settings = {
    vim = {
      languages = {
        clang = {
          enable = true;
          lsp.enable = true;
          treesitter.enable = true;
          dap.enable = true;
        };
      };
    };
  };
}
