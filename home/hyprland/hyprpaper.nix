{ config, lib, pkgs, ... }:

let
  wp = toString config.style.wallpaperPath; 
in
{
  services.hyprpaper = {
    enable = true;

    settings = {
      source = "~/.config/hypr/hyprpaper.conf";
    };
  };

  xdg.configFile."hypr/hyprpaper.conf".text = ''
    ipc = true
    splash = false

    wallpaper {
      monitor = eDP-1
      path = ${wp}
      fit_mode = cover
      # timeout = 30    # only matters if `path` is a directory
    }
  '';
}
