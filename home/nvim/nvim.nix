{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    neovim
    lua-language-server
    fd
    ripgrep
    gcc
    clang-tools
  ];

  home.file.".config/nvim/init.lua" = {
    source = ./nvim/init.lua;
  };
  
  home.file.".config/nvim/lua" = {
    source = ./nvim/lua;
    recursive = true;
  };

}
