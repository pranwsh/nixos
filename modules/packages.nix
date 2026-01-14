{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [

    wl-clipboard
    brightnessctl
    playerctl
    pamixer
    acpi

    unzip
    ripgrep
    git

  ];
}
