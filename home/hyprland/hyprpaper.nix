{ config, pkgs, ... }:

let
  wallpaperFile = config.style.wallpaperPath;

  wallpaper = builtins.path { path = wallpaperFile; name = "wallpaper"; };
in
{
  services.hyprpaper = {
    enable = true;

    settings = {
      preload = [ "${wallpaper}" ];
      wallpaper = [ "eDP-1,${wallpaper}" ];
      splash = false;
      ipc = "on";
    };
  };
}
