{pkgs, ...}: {
  home.packages = with pkgs; [
    hyprpaper
  ];

  # hyprpaper configuration file
  xdg.configFile."hypr/hyprpaper.conf".text = ''
    preload = /etc/nixos/home/wallpapers/a_planet_in_space_with_clouds.jpg
    
    wallpaper = eDP-1,/etc/nixos/home/wallpapers/a_planet_in_space_with_clouds.jpg
    
    splash = false
    ipc = on
  '';

  wayland.windowManager.hyprland.settings = {
    exec-once = [ 
      "${pkgs.hyprpaper}/bin/hyprpaper"
    ];
  };
}
