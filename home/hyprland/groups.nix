{ config, pkgs, lib, walNix, ... }:
let
  theme = config.style;
  c = (import "${walNix}/colors.nix").colorscheme;

  stripHash = s: lib.removePrefix "#" s;

  # Hyprland accepts rgba(rrggbbaa) (8 hex chars, no #).
  rgba = hex: a: "rgba(${stripHash hex}${a})";
in
{
  wayland.windowManager.hyprland.settings = {
    "group:groupbar" = {
      enabled = true;

      # no text, just a thin bar
      render_titles = false;
      font_size = 1;          # irrelevant when render_titles=false, but harmless
      text_padding = 0;
      text_offset = 0;
      text_color = "0x00ffffff";  # fully transparent (also irrelevant)

      # make it thin
      height = 4;
      indicator_height = 4;
      indicator_gap = 0;
      keep_upper_gap = false;

      # gradients on
      gradients = true;

      # bright active gradient
      "col.active" =
        "${rgba c.color2 "ff"} ${rgba c.color6 "ff"} 45deg";

      # dim inactive gradient
      "col.inactive" =
        "${rgba c.color8 "66"} ${rgba c.color0 "66"} 45deg";

      # optional: locked colors (still consistent)
      "col.locked_active" =
        "${rgba c.color1 "ff"} ${rgba c.color5 "ff"} 45deg";
      "col.locked_inactive" =
        "${rgba c.color8 "66"} ${rgba c.color0 "66"} 45deg";

      # keep it clean
      stacked = false;
      scrolling = true;
      rounding = 1;
      rounding_power = 2.0;
      gradient_rounding = 1;
      gradient_rounding_power = 2.0;
      round_only_edges = true;
      gradient_round_only_edges = true;
    };
  };
}
