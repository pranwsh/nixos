{pkgs, ...}: {
  home.packages = with pkgs; [
    hyprpaper
  ];

  # hyprpaper configuration file
  xdg.configFile."hypr/hyprpaper.conf".text = ''
    preload = /home/pranesh/Pictures/Wallpapers/fish
    
    wallpaper = eDP-1,/home/pranesh/Pictures/Wallpapers/fish
    
    splash = false
    ipc = on
  '';

  wayland.windowManager.hyprland.settings = {
    exec-once = [ 
      "${pkgs.hyprpaper}/bin/hyprpaper"
    ];
  };
}
