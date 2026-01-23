{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./options/default.nix
    ./plugins/default.nix
    ./plugins/whichkey.nix
  ];

  programs.nvf = {
    enable = true;
  };
}
