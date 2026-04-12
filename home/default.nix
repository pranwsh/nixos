{ pkgs, ... }:
{
  imports = [
    ./code/default.nix
    ./style.nix
    ./hyprland/default.nix
    ./gtk.nix
    ./kitty.nix
    ./fish.nix
    ./zathura/zathura.nix
    ./zathura/persist.nix
    ./latex.nix
    ./zen/default.nix
    ./spotify/default.nix
    ./nvim/default.nix
    ./prismlauncher.nix
    ./flatpak.nix
    ./wofi.nix
    ./pywal.nix
    ./scripts/nixify/nixify.nix
    ./kdeconnect.nix
  ];

  home.username = "pranesh";
  home.homeDirectory = "/home/pranesh";

  home.packages = [
    pkgs.wineWow64Packages.stable
    pkgs.discord
    pkgs.libreoffice
    pkgs.qemu
    pkgs.chromium
    pkgs.bluetui
    pkgs.impala
    pkgs.yazi
    pkgs.maxima
  ];

  home.stateVersion = "24.11";
  programs.home-manager.enable = true;
}
