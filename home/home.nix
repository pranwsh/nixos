{ config, pkgs, inputs, ... }:

{
  imports = [
    ./hyprland.nix
      ./hyprpaper.nix
      ./cursor.nix
      ./kitty.nix
      ./bash.nix
      ./zathura.nix
      ./latex.nix
      ./zen/zen.nix
      ./spotify/spotify.nix
      ./nvim/nvim.nix
      ./prismlauncher.nix
      ./flatpak.nix
  ];

  home.username = "pranesh";
  home.homeDirectory = "/home/pranesh";

  home.packages = with pkgs; [
      tree-sitter
      wineWowPackages.stable
      gemini-cli
      discord
      plasma5Packages.kdeconnect-kde
      libreoffice
      python3
      qemu
  ];

  home.stateVersion = "24.11";
  programs.home-manager.enable = true;


}
