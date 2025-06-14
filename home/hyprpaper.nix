{ config, pkgs, ... }:

{
 # Install hyprpaper
  home.packages = with pkgs; [ hyprpaper ];

  # Configure hyprpaper
  xdg.configFile."hypr/hyprpaper.conf".text = ''
    preload = /home/pranesh/Pictures/Wallpapers/Fractal Maze/23.jpg
    wallpaper = eDP-1,/home/pranesh/Pictures/Wallpapers/Fractal Maze/23.jpg
  '';

  # Start hyprpaper with Hyprland 
  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = ''
      exec-once = ${pkgs.hyprpaper}/bin/hyprpaper
    '';
  };
}
