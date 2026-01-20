{ config, lib, pkgs, ... }:

{
  imports = [
    ./options/default.nix
    ./plugins/default.nix
  ];

  programs.nvf = {
    enable = true;
  };
}
