{...}: {
  programs.nvf.settings = {
    vim = {
      languages = {
        enableTreesitter = true;
        enableFormat = true;
        # Nix Setup
        nix = {
          enable = true;
          lsp.enable = true;
          lsp.servers = ["nil"];
          format.enable = true;
          format.type = ["alejandra"];
        };
      };
    };
  };
}
