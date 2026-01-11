{ ... }:
{
  wayland.windowManager.hyprland.settings = {
    bind = [
      # =========================
      # Focus move
      # =========================
      "$mainMod, h, movefocus, l"
      "$mainMod, l, movefocus, r"
      "$mainMod, k, movefocus, u"
      "$mainMod, j, movefocus, d"
      # =========================
      # Move window
      # =========================
      "$mainMod SHIFT, h, movewindow, l"
      "$mainMod SHIFT, l, movewindow, r"
      "$mainMod SHIFT, k, movewindow, u"
      "$mainMod SHIFT, j, movewindow, d"

      # =========================
      # Groups (Hyprland native tabs)
      # =========================
      "$mainMod, t, togglegroup"
      "$mainMod, tab, changegroupactive, f"
      "$mainMod SHIFT, tab, changegroupactive, b"
      "$mainMod, g, moveintogroup"
      "$mainMod SHIFT, g, moveoutofgroup"

      # =========================
      # Split ratio (keep only)
      # =========================
      "$mainMod, equal, splitratio, +0.05"
      "$mainMod, minus, splitratio, -0.05"
      "$mainMod SHIFT, f, splitratio, exact 1"
    ];
  };
}
