{pkgs, ...}: {
  home.packages = with pkgs; [
    hyprpaper
  ];

  # hyprpaper configuration file
  xdg.configFile."hypr/hyprpaper.conf".text = ''
    preload = /home/pranesh/Pictures/Wallpapers/Fractal Maze/19.jpg
    
    wallpaper = eDP-1,/home/pranesh/Pictures/Wallpapers/Fractal Maze/19.jpg
    
    splash = false
    ipc = on
  '';

  wayland.windowManager.hyprland.settings = {
    exec-once = [ 
      "${pkgs.hyprpaper}/bin/hyprpaper"
    ];
  };
}
