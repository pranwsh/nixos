{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [

    nodejs_23

    wl-clipboard
    brightnessctl
    playerctl
    pamixer
    acpi

    ranger

    unzip
    ripgrep
    fzf
    neovim
    git

  ];
}
