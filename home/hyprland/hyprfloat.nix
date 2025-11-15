{ config, pkgs, ... }:
{
  services.hyprfloat = {
    enable = true;
    autoStart = true;  # Automatically start with Hyprland
    
    settings = {
      terminal_classes = [
        "kitty"
      ];
      
      ignore_titles = [
        "cava"
        "btop"
        "htop"
      ];
      
      monitors = {
        "DP-1" = {
          width = 1152;
          height = 648;
          offset = [ 0 0 ];
        };
      };
    };
  };
}
