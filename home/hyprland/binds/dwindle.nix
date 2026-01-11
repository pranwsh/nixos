{ ... }:
{
  wayland.windowManager.hyprland.settings = {
    bind = [
      # =========================
      # Fullscreen / maximize
      # =========================
      "SUPER, comma, fullscreen, 1"  # maximize-ish (keeps gaps/bar)

      # =========================
      # Move windows (reposition in dwindle tree)
      # =========================
      # arrows
      "SUPER SHIFT, period, movewindow, r"
      "SUPER SHIFT, comma, movewindow, l"
      "SUPER SHIFT, up, movewindow, u"
      "SUPER SHIFT, down, movewindow, d"

      # vim keys (same idea)
      "$mainMod SHIFT, h, movewindow, l"
      "$mainMod SHIFT, l, movewindow, r"
      "$mainMod SHIFT, k, movewindow, u"
      "$mainMod SHIFT, j, movewindow, d"

      # =========================
      # Split ratio control
      # =========================
      "SUPER, bracketright, splitratio, +0.05"
      "SUPER, bracketleft, splitratio, -0.05"

      "$mainMod, equal, splitratio, +0.05"
      "$mainMod, minus, splitratio, -0.05"

      # Reset split ratio
      "SUPER SHIFT, F, splitratio, exact 1"
      "$mainMod SHIFT, f, splitratio, exact 1"

      # =========================
      # Split direction / structure control
      # =========================
      # Toggle split direction for the focused container
      "SUPER SHIFT, G, togglesplit,"
      "$mainMod SHIFT, g, togglesplit,"

      # Flip the split (alternate toggle that often feels more “predictable”)
      "$mainMod, F, layoutmsg, togglesplit"

      # Rotate the dwindle subtree (useful when layout feels “wrong”)
      "$mainMod, R, layoutmsg, rotate"

      # =========================
      # Preselect (force where NEXT window goes)
      # =========================
      "SUPER SHIFT, C, layoutmsg, preselect d"  # down
      "SUPER SHIFT, L, layoutmsg, preselect r"  # right
      "SUPER SHIFT, H, layoutmsg, preselect l"  # left

      "$mainMod SHIFT, c, layoutmsg, preselect d"

      # Add the missing ones so it’s complete + predictable
      "$mainMod SHIFT, k, layoutmsg, preselect u"
      "$mainMod SHIFT, j, layoutmsg, preselect d"
      "$mainMod SHIFT, h, layoutmsg, preselect l"
      "$mainMod SHIFT, l, layoutmsg, preselect r"

      # Cancel preselect (stop “why did it go there?” moments)
      "$mainMod, escape, layoutmsg, cancelpreselect"

      # =========================
      # Native Hyprland grouping (tabs)
      # NOTE: this is Hyprland's group system, not hy3
      # =========================
      # Toggle group on focused window (create/ungroup)
      "$mainMod, T, togglegroup"

      # Cycle active tab in group
      "$mainMod, tab, changegroupactive, f"
      "$mainMod SHIFT, tab, changegroupactive, b"

      # Move current window into/out of group
      "$mainMod, G, moveintogroup"
      "$mainMod SHIFT, G, moveoutofgroup"

      # Optional: swap within group (handy for reordering)
      "$mainMod SHIFT, left, movegroupwindow, b"
      "$mainMod SHIFT, right, movegroupwindow, f"

      # =========================
      # Quality-of-life dwindle actions
      # =========================
      # Swap with "master" (dwindle’s closest thing to “promote”)
      "$mainMod, return, layoutmsg, swapwithmaster"

      # Split in a forced orientation next time (more explicit than toggles)
      "$mainMod, H, layoutmsg, preselect l"
      "$mainMod, L, layoutmsg, preselect r"
      "$mainMod, K, layoutmsg, preselect u"
      "$mainMod, J, layoutmsg, preselect d"
    ];

    # Mouse wheel split ratio
    # NOTE: hyprland usually uses bindm for mouse stuff, but your format works if it’s being parsed.
    # If it doesn’t, move these to bindm.
    bindm = [
      "$mainMod, mouse_down, splitratio, -0.05"
      "$mainMod, mouse_up, splitratio, +0.05"
    ];
  };
}
