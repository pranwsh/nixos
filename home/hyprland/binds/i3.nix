
# binds/i3-binds.nix
{ ... }:
{
  wayland.windowManager.hyprland.settings = {
    bind = [
      # =========================
      # i3-style navigation (hy3)
      # h/l = focus left/right
      # j/k = focus down/up
      # =========================
      "$mainMod, h, hy3:movefocus, l"
      "$mainMod, l, hy3:movefocus, r"
      "$mainMod, j, hy3:movefocus, d"
      "$mainMod, k, hy3:movefocus, u"

      # =========================
      # i3-style move windows (SHIFT)
      # =========================
      "$mainMod SHIFT, h, hy3:movewindow, l"
      "$mainMod SHIFT, l, hy3:movewindow, r"
      "$mainMod SHIFT, j, hy3:movewindow, d"
      "$mainMod SHIFT, k, hy3:movewindow, u"

      # =========================
      # Window sizing
      # =========================
      "$mainMod, minus, resizeactive, -50 0"
      "$mainMod, equal, resizeactive, 50 0"

      # =========================
      # Tab management (hy3 feature)
      # =========================
      "$mainMod, T, hy3:makegroup, tab"
      "$mainMod SHIFT, T, hy3:makegroup, opposite"
      "$mainMod, G, hy3:changegroup, toggletab"
    ];
  };
}
