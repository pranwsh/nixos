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
  ];

  home.username = "pranesh";
  home.homeDirectory = "/home/pranesh";

  home.packages = with pkgs; [
    wineWowPackages.stable
    gemini-cli
  ];

  home.stateVersion = "24.11";
  programs.home-manager.enable = true;


}
