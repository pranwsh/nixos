{pkgs, ...}: {
  # Install hyprpaper
  home.packages = with pkgs; [
    hyprpaper
  ];

  # Configure hyprpaper
  xdg.configFile."hypr/hyprpaper.conf".text = ''
    preload = /home/pranesh/Pictures/Wallpapers/Unsplash/waves
    wallpaper = eDP-1,/home/pranesh/Pictures/Wallpapers/Unsplash/waves
  '';

  # Start hyprpaper with Hyprland
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "${pkgs.hyprpaper}/bin/hyprpaper"
    ];
  };
}
