{inputs, ...}: {
  imports = [
    inputs.nvf.homeManagerModules.default
    ./options/default.nix
    ./plugins/default.nix
  ];

  programs.nvf = {
    enable = true;
  };
}
