{ config, pkgs, inputs, ... }:

let
  pythonEnv = pkgs.python3.withPackages (ps: with ps; [
    pynvim
    pip
  ]);
in
{
  imports = [
    ./hyprland/default.nix
    ./cursor.nix
    ./kitty.nix
    ./fish.nix
    ./zathura.nix
    ./latex.nix
    ./zen/default.nix
    ./spotify/default.nix
    ./nvim/default.nix
    ./prismlauncher.nix
    ./flatpak.nix
    ./wofi.nix
    ./pywal.nix
  ];
  
  home.username = "pranesh";
  home.homeDirectory = "/home/pranesh";
  
  home.packages = [
    pythonEnv
    pkgs.tree-sitter
    pkgs.wineWowPackages.stable
    pkgs.gemini-cli
    pkgs.discord
    pkgs.libreoffice
    pkgs.qemu
    pkgs.chromium
    pkgs.bluetui
    pkgs.impala
    pkgs.lmms
  ];
  
  home.stateVersion = "24.11";
  programs.home-manager.enable = true;
}
