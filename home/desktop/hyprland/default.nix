{ ... }: {
  imports = [
    ./settings.nix
    ./windows.nix
    ./monitors.nix
    ./hyprpaper.nix
    ./hyprshot.nix
    ./wl-clipboard.nix
    ./binds/default.nix
    ./groups.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    configType = "lua";
  };
}
