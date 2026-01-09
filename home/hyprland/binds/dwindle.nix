
{ ... }:
{
  wayland.windowManager.hyprland.settings = {
    bind = [
      # Fullscreen toggle
      "SUPER, comma, fullscreen, 1"  # Halfscreen (maximize, keeps gaps/bar)

      # Move windows in dwindle (arrows)
      "SUPER SHIFT, period, movewindow, r"
      "SUPER SHIFT, comma, movewindow, l"
      "SUPER SHIFT, up, movewindow, u"
      "SUPER SHIFT, down, movewindow, d"

      # Split ratio control
      "SUPER, bracketright, splitratio, +0.05"
      "SUPER, bracketleft, splitratio, -0.05"

      # Reset split ratio
      "SUPER SHIFT, F, splitratio, exact 1"

      # Toggle split direction
      "SUPER SHIFT, G, togglesplit,"

      # Preselect (next window placement)
      "SUPER SHIFT, C, layoutmsg, preselect d"  # down
      "SUPER SHIFT, L, layoutmsg, preselect r"  # right
      "SUPER SHIFT, H, layoutmsg, preselect l"  # left

      # Move windows (swap positions in dwindle tree) - vim keys
      "$mainMod SHIFT, h, movewindow, l"
      "$mainMod SHIFT, l, movewindow, r"
      "$mainMod SHIFT, k, movewindow, u"
      "$mainMod SHIFT, j, movewindow, d"

      # Adjust split ratios (alt set)
      "$mainMod, equal, splitratio, +0.05"
      "$mainMod, minus, splitratio, -0.05"

      # Reset split ratio & toggle split (lowercase duplicates)
      "$mainMod SHIFT, f, splitratio, exact 1"
      "$mainMod SHIFT, g, togglesplit,"

      # Preselect next window position (duplicate shortcut)
      "$mainMod SHIFT, c, layoutmsg, preselect d"

      # Mouse wheel binds for split ratio
      "$mainMod, mouse_down, splitratio, -0.05"
      "$mainMod, mouse_up, splitratio, +0.05"
    ];
  };
}
