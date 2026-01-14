{ config, pkgs, inputs, ... }:
{
  imports = [
    ./style.nix
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
    ./python.nix
    ./java.nix
    ./scripts/nixify/nixify.nix
    ./cpp.nix
  ];
  home.username = "pranesh";
  home.homeDirectory = "/home/pranesh";
  home.packages = [
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
    pkgs.yazi
  ];
  home.stateVersion = "24.11";
  programs.home-manager.enable = true;
}
