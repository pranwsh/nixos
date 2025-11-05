{pkgs, ...}: {
  # Install mpvpaper
  home.packages = with pkgs; [
    mpvpaper
  ];

  # Start mpvpaper with Hyprland
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "${pkgs.mpvpaper}/bin/mpvpaper -o 'no-audio loop' eDP-1 /home/pranesh/Pictures/Wallpapers/Live/cat.mp4"
    ];
  };
}
