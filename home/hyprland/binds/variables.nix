# binds/variables.nix
{ ... }:
{
  wayland.windowManager.hyprland.settings = {
    "$mainMod" = "SUPER";
    "$terminal" = "kitty";
    "$browser" = "zen";
    "$spotify" = "spotify";
    "$menu" = "wofi";
    "$chromium" = "chromium";
  };
}
