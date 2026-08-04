# groupbar.nix
{ config, pkgs, lib, ... }:
let
  theme = config.style;
  stripHash = s: lib.removePrefix "#" s;
  argb = a: hex: "rgba(${stripHash hex}${a})";
in
{
  wayland.windowManager.hyprland.settings = {
    config = {
      group = {
        groupbar = {
          rounding = 3;
          rounding_power = 2.0;
          round_only_edges = false;
          height = 6;
          indicator_height = 6;
          font_size = 2;
          render_titles = false;
          text_color = 0;
          blur = true;

          col = {
            active = argb "ff" theme.colors.color12;
            inactive = argb "80" theme.colors.color4;
          };
        };
      };
    };
  };
}
