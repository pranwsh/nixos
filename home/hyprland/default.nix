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
    ./hyprscrolling.nix
    ./binds/default.nix
  ];
  
  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
  };
  
  home.packages = with pkgs; [
    
  ];
}
