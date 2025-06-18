{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    neovim
    lua-language-server
    fd
    ripgrep
  ];

  xdg.configFile."nvim".source = ./nvim;
}
