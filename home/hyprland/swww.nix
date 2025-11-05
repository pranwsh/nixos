{ pkgs, ... }: {
  # Install swww (Wayland wallpaper daemon)
  home.packages = with pkgs; [
    swww
  ];

  # Start swww when Hyprland starts
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      # Initialize swww
      "${pkgs.swww}/bin/swww init"

      # Set your GIF wallpaper (cat.gif instead of cat.mp4)
      "${pkgs.swww}/bin/swww img /home/pranesh/Pictures/Wallpapers/Live/cat.gif --transition-type any --transition-fps 60 --transition-duration 1"
    ];
  };
}
