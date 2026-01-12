{ ... }:
{
  wayland.windowManager.hyprland = {
    settings = {
      bind = [
        # =========================
        # Hyprscrolling column swaps
        # =========================
        "SUPER, comma,  layoutmsg, swapcol l"
        "SUPER, period, layoutmsg, swapcol r"

        # =========================
        # Move focus (between windows)
        # =========================
        "SUPER, h, movefocus, l"
        "SUPER, l, movefocus, r"
        "SUPER, j, movefocus, d"
        "SUPER, k, movefocus, u"

        # =========================
        # Move windows (physically)
        # =========================
        "SUPER SHIFT, h, movewindow, l"
        "SUPER SHIFT, l, movewindow, r"
        "SUPER SHIFT, j, movewindow, d"
        "SUPER SHIFT, k, movewindow, u"
      ];
    };
  };
}
