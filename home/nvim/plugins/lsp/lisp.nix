{...}: {
  programs.nvf.settings = {
    vim = {
      languages = {
        enableTreesitter = true;
        enableFormat = true;
        # Common Lisp via SLY/SLIME — LSP support is limited upstream
        lisp = {
          enable = true;
          lsp.enable = true;
          lsp.servers = ["cl-lsp"];
          format.enable = true;
          format.type = ["lisplefmt"];
        };
      };
    };
  };
}
