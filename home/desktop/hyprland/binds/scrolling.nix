{ ... }:
{
  wayland.windowManager.hyprland.settings = {
    # hyprscrolling only works if you actually use the scrolling layout

    bind = [
      # =========================
      # FOCUS (niri/paperwm-style)
      # =========================
      "$mainMod, h, layoutmsg, focus l"
      "$mainMod, l, layoutmsg, focus r"
      "$mainMod, k, layoutmsg, focus u"
      "$mainMod, j, layoutmsg, focus d"

      "$mainMod, left,  layoutmsg, focus l"
      "$mainMod, right, layoutmsg, focus r"
      "$mainMod, up,    layoutmsg, focus u"
      "$mainMod, down,  layoutmsg, focus d"

      # =========================
      # MOVE WINDOW (to columns/stack)
      # (hyprscrolling-native; behaves better than plain movewindow)
      # =========================
      "$mainMod SHIFT, h, layoutmsg, movewindowto l"
      "$mainMod SHIFT, l, layoutmsg, movewindowto r"
      "$mainMod SHIFT, k, layoutmsg, movewindowto u"
      "$mainMod SHIFT, j, layoutmsg, movewindowto d"

      "$mainMod SHIFT, left,  layoutmsg, movewindowto l"
      "$mainMod SHIFT, right, layoutmsg, movewindowto r"
      "$mainMod SHIFT, up,    layoutmsg, movewindowto u"
      "$mainMod SHIFT, down,  layoutmsg, movewindowto d"

      # =========================
      # YOUR REQUEST: swap left/right on SUPER + , and .
      # (true swap via core Hyprland dispatcher)
      # =========================
      "$mainMod, comma,  exec, hyprctl dispatch layoutmsg swapcol l && hyprctl dispatch layoutmsg focus r && hyprctl dispatch layoutmsg move +col"
      "$mainMod, period, exec, hyprctl dispatch layoutmsg swapcol r && hyprctl dispatch layoutmsg focus l && hyprctl dispatch layoutmsg move -col"

      # =========================
      # SCROLL THE WORKSPACE VIEWPORT BY COLUMN
      # (moves the “camera” across columns)
      # =========================
      "$mainMod ALT, comma,  layoutmsg, move -col"
      "$mainMod ALT, period, layoutmsg, move +col"

      # =========================
      # PROMOTE (make a new column)
      # =========================
      "$mainMod, Return, layoutmsg, promote"

      # =========================
      # FIT / RESIZE HELPERS (make it “actually usable”)
      # =========================
      # Fill the screen with the active column/window set
      "$mainMod, Space, layoutmsg, fit active"

      # Quick “unfill” back to a sane default + refocus
      "$mainMod SHIFT, Space, exec, hyprctl dispatch layoutmsg colresize 0.5 && hyprctl dispatch layoutmsg focus"

      # Make everything currently visible fit nicely
      "$mainMod, F, layoutmsg, fit visible"

      # Nudge column size (two common steps)
      "$mainMod, bracketleft,  layoutmsg, colresize 0.45"
      "$mainMod, bracketright, layoutmsg, colresize 0.55"

      # =========================
      # BASICS YOU PROBABLY STILL WANT
      # =========================
      "$mainMod, C, killactive,"
      "$mainMod, V, togglefloating,"
      "$mainMod, M, exit,"
      "$mainMod, T, togglesplit,"  # harmless even if scrolling ignores it
    ];

    # Optional: mouse move/resize for floats
    bindm = [
      "$mainMod, mouse:272, movewindow"
      "$mainMod, mouse:273, resizewindow"
    ];
  };
}
