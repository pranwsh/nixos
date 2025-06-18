{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    neovim
    lua-language-server
    fd
    ripgrep
    gcc
  ];

#  xdg.configFile."nvim".source = ./nvim;
}
