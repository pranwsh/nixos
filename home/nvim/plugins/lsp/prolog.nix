{...}: {
  programs.nvf.settings = {
    vim = {
      languages = {
        enableTreesitter = true;
        enableFormat = true;
        # Prolog LSP via SWI-Prolog's built-in language server
        prolog = {
          enable = true;
          lsp.enable = true;
          lsp.servers = ["prolog-lsp"];
          format.enable = false; # No widely adopted formatter yet
        };
      };
    };
  };
}
