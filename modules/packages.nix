{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [

    wl-clipboard
    brightnessctl
    playerctl
    pamixer
    acpi

    ranger

    unzip
    ripgrep
    fzf
    git
    gparted

    gemini-cli

  ];
}
