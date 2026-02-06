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
      # Explicitly enable Treesitter indent module
      treesitter = {
        fold = false;
        enable = true;
        indent.enable = true; # This is the key line
      };
      visuals = {
        nvim-web-devicons.enable = true;
      };
    };
  };
}
