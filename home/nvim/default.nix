{ config, pkgs, lib, walNix, ... }:
let
  pythonEnv = pkgs.python3.withPackages (ps: with ps; [
    pynvim
    flask
  ]);
  c = (import "${walNix}/colors.nix").colorscheme;
in
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    
    extraPackages = with pkgs; [
      # LSP servers
      lua-language-server
      pyright
      nodePackages.typescript-language-server
      nil
      clang-tools
      
      # Linters/Formatters
      ruff
      nodePackages.eslint_d
      stylua
      nodePackages.prettier
      
      # Python environment
      pythonEnv
    ];
  };

  home.file.".config/nvim/nix-colors.json".text = builtins.toJSON c;
  home.file.".config/nvim/init.lua" = {
    source = ./nvim/init.lua;
  };
  home.file.".config/nvim/lua" = {
    source = ./nvim/lua;
    recursive = true;
  };
}
