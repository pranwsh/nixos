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
    ./keybindings.nix
    ./windows.nix
    ./monitors.nix
    ./hyprpaper.nix
    ./hyprshot.nix
    ./hypridle.nix
  ];
  
  wayland.windowManager.hyprland = {
    enable = true;
    
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    
    plugins = [
    ];
  };
  
  home.packages = with pkgs; [
    
  ];
}
