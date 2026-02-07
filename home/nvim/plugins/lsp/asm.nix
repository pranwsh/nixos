{...}: {
  programs.nvf.settings = {
    vim = {
      languages.assembly = {
        enable = true;
        treesitter.enable = true;
        lsp.enable = true;
      };
    };
  };
}
