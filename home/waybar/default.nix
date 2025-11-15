{ config, pkgs, ... }:

{
  programs.waybar = {
    enable = true;
    package = pkgs.waybar; # or your hyprland-patched waybar if you use one
  };

  xdg.configFile."waybar/config".source = ./config/config;
  xdg.configFile."waybar/style.css".source = ./config/style.css;
}
