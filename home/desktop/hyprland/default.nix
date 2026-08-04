{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./settings.nix
    ./windows.nix
    ./monitors.nix
    ./hyprpaper.nix
    ./hyprshot.nix
    ./binds/default.nix
    ./groups.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    configType = "lua";
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
  };
}
