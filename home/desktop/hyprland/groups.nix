# groupbar.nix
{ config, pkgs, lib, ... }:
let
  theme = config.style;
  stripHash = s: lib.removePrefix "#" s;
  argb = a: hex: "0x${a}${stripHash hex}";
in
{
  wayland.windowManager.hyprland.settings = {
    "group:groupbar:rounding" = 3;
    "group:groupbar:rounding_power" = 2.0;
    "group:groupbar:round_only_edges" = false;
    "group:groupbar:height" = 6;
    "group:groupbar:indicator_height" = 6;
    "group:groupbar:font_size" = 0;
    "group:groupbar:render_titles" = false;
    "group:groupbar:text_color" = "0x00000000";

    "group:groupbar:blur" = true;
    "group:groupbar:col.active" = argb "ff" theme.colors.color12;
    "group:groupbar:col.inactive" = argb "80" theme.colors.color4;
  };
}
