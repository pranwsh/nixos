{
  config,
  lib,
  pkgs,
  ...
}: let
  wp = toString config.style.wallpaperPath;
in {
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = true;
      splash = false;

      wallpaper = [
        {
          monitor = "eDP-1";
          path = wp;
          fit_mode = "cover";
        }
        {
          monitor = "HDMI-A-1";
          path = wp;
          fit_mode = "cover";
        }
      ];
    };
  };
}