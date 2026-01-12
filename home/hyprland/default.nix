{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: 

{
  imports = [
    ./settings.nix
    ./windows.nix
    ./monitors.nix
    ./hyprpaper.nix
    ./hyprshot.nix
    ./binds/default.nix
    ./hyprscrolling.nix
  ];
  
  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
  };
  
  home.packages = with pkgs; [
    
  ];
}
