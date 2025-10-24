{ config, pkgs, ... }:

{
  # Install Hyprshot along with Hyprpaper if desired
  home.packages = with pkgs; [
    hyprshot
    hyprpaper
  ];

  # Configure Hyprland
  wayland.windowManager.hyprland = {
    enable = true;

    extraConfig = ''
      # Start hyprpaper
      exec-once = ${pkgs.hyprpaper}/bin/hyprpaper

      # Hyprshot keybindings
      # Capture full screen
      bind = SUPER, PRINT, exec, ${pkgs.hyprshot}/bin/hyprshot -m output
      # Capture focused window
      bind = SUPER+SHIFT, PRINT, exec, ${pkgs.hyprshot}/bin/hyprshot -m window
      # Capture a selected region
      bind = SUPER+CTRL, PRINT, exec, ${pkgs.hyprshot}/bin/hyprshot -m region
    '';
  };
}
