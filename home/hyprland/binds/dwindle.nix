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
      "$mainMod CTRL, tab, changegroupactive, b"
      "$mainMod CTRL, H, moveintogroup, l"
      "$mainMod CTRL, L, moveintogroup, r"
      "$mainMod CTRL, K, moveintogroup, u"
      "$mainMod CTRL, J, moveintogroup, d"
      "$mainMod P, moveoutofgroup"
      "$mainMod L, lockactivegroup"

      # =========================
      # Split ratio (keep only)
      # =========================
      "$mainMod, equal, splitratio, +0.05"
      "$mainMod, minus, splitratio, -0.05"
      "$mainMod SHIFT, f, splitratio, exact 1"
    ];
  };
}
