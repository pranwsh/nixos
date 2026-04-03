{...}: {
  programs.nvf.settings = {
    vim = {
      languages = {
        enableTreesitter = true;
        enableFormat = true;
        go = {
          enable = true;
          lsp.enable = true;
          lsp.servers = ["gopls"];
          format.enable = true;
          format.type = ["gofmt"];
        };
      };
    };
  };
}
