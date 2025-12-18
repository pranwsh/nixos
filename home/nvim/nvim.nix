{ config, pkgs, lib, walNix, ... }:

let
  pythonEnv = pkgs.python3.withPackages (ps: with ps; [
    pynvim
    flask
  ]);

  # You said your wal colors are accessed like this:
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

  # Write the Nix colors into Neovim's config dir as JSON
  # (avoids conflicts with your recursive lua/ copy)
  home.file.".config/nvim/nix-colors.json".text = builtins.toJSON c;

  # Your existing nvim config layout
  home.file.".config/nvim/init.lua" = {
    source = ./nvim/init.lua;
  };

  home.file.".config/nvim/lua" = {
    source = ./nvim/lua;
    recursive = true;
  };
}
