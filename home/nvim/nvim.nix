{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    neovim
    lua-language-server
  ];

  xdg.configFile."nvim".source = ./nvim;
}
