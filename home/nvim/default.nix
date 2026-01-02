{ config, pkgs, lib, walNix, ... }:

let
  pythonEnv = pkgs.python3.withPackages (ps: with ps; [
    pynvim
    flask
  ]);

  c = (import "${walNix}/colors.nix").colorscheme;
in
{
  home.packages = with pkgs; [
    neovim
    lua-language-server
    tree-sitter
    fd
    ripgrep
    gcc
    clang-tools
  ];

  home.file.".config/nvim/nix-colors.json".text = builtins.toJSON c;

  home.file.".config/nvim/init.lua" = {
    source = ./nvim/init.lua;
  };

  home.file.".config/nvim/lua" = {
    source = ./nvim/lua;
    recursive = true;
  };
}
