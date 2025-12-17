{pkgs, ...}: {
  home.packages = with pkgs; [
    hyprpaper
  ];

  # hyprpaper configuration file
  xdg.configFile."hypr/hyprpaper.conf".text = ''
    preload = /home/pranesh/Pictures/Wallpapers/newer/a_planet_in_the_sky.jpg
    
    wallpaper = eDP-1,/home/pranesh/Pictures/Wallpapers/newer/a_planet_in_the_sky.jpg
    
    splash = false
    ipc = on
  '';

  wayland.windowManager.hyprland.settings = {
    exec-once = [ 
      "${pkgs.hyprpaper}/bin/hyprpaper"
    ];
  };
}
