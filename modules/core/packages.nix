{ config, lib, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

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
