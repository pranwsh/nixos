{ config, pkgs, lib, ... }:

{
  home.packages = [
    pkgs.yazi
  ];

  # Symlink ~/.config/nvim to ./nvim (relative to this file)
  xdg.configFile."yazi".source = ./yazi;
}
