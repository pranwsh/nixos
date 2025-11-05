{pkgs, ...}: {
  home.packages = with pkgs; [
    mpvpaper
  ];
  wayland.windowManager.hyprland.settings = {
    exec-once = [ 
      "${pkgs.mpvpaper}/bin/mpvpaper -o 'no-audio loop' eDP-1 /home/pranesh/Pictures/Wallpapers/Live/cat.webm"
    ];
  };
}

