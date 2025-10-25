{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    hyprshot
  ];
  
  # Create the Screenshots directory
  home.file."Pictures/Screenshots/.keep".text = "";
  
  # Configure Hyprland
  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = ''
      # Start hyprpaper
      exec-once = ${pkgs.hyprpaper}/bin/hyprpaper
      
      # Hyprshot keybindings with output directory specified
      # Capture full screen
      bind = SUPER, Z, exec, ${pkgs.hyprshot}/bin/hyprshot -m output -o ~/Pictures/Screenshots
      
      # Capture focused window
      bind = SUPER+SHIFT, Z, exec, ${pkgs.hyprshot}/bin/hyprshot -m window -o ~/Pictures/Screenshots
      
      # Capture a selected region
      bind = SUPER+CTRL, Z, exec, ${pkgs.hyprshot}/bin/hyprshot -m region -o ~/Pictures/Screenshots
    '';
  };
}
