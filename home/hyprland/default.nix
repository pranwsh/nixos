{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: let
  hyprscrollingPlugin = inputs.hyprland-plugins.packages.x86_64-linux.hyprscrolling;
in {
  imports = [
    ./settings.nix
    ./keybindings.nix
    ./windows.nix
    ./monitors.nix
    ./hyprpaper.nix
    ./hyprshot.nix
    ./hyprscrolling.nix
    ./shader.nix
  ];
  
  wayland.windowManager.hyprland = {
    enable = true;
    
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    
    plugins = [
      hyprscrollingPlugin
    ];
  };
  
  home.packages = with pkgs; [
    
  ];
}
