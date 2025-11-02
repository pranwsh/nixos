{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./settings.nix
    ./keybindings.nix
    ./windows.nix
    ./monitors.nix
    ./hyprpaper.nix
    ./hyprshot.nix
    ./hyprscrolling.nix
  ];
  
  wayland.windowManager.hyprland = {
    enable = true;
    
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    
    plugins = [
      inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.hyprscrolling
    ];
  };
  
  home.packages = with pkgs; [
  
  ];
}
