{ config, pkgs, lib, ... }:

{
  home.packages = [
    pkgs.neovim
  ];

  xdg.configFile."nvim".source = ./nvim;
}
