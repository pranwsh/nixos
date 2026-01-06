{ config, lib, pkgs, ... }:

let
  wp = toString config.style.wallpaperPath; # file OR directory
in
{
  services.hyprpaper = {
    enable = true;

    # Keep this minimal so we don't feed old-style values like ipc="on"
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
