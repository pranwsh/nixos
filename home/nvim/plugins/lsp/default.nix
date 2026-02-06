{...}: {
  imports = [
    ./c.nix
    ./asm.nix
    ./nix.nix
  ];

  programs.nvf.settings = {
    vim = {
      lsp = {
        enable = true;
        formatOnSave = true;
      };

      languages = {
        enableTreesitter = true;
        enableFormat = true;
      };

      visuals = {
        nvim-web-devicons.enable = true;
      };
    };
  };
}
