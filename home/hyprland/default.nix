{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./settings.nix
    ./keybindings.nix
    ./windows.nix
    ./monitors.nix
    ./hyprpaper.nix
    ./hyprshot.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
  };

  home.packages = with pkgs; [
    # Add any Hyprland-related packages here
  ];
}
