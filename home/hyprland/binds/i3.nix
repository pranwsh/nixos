{ ... }:
{
  wayland.windowManager.hyprland.settings = {
    bind = [
      # =========================================================
      # HY3 FOCUS (niri-ish / i3-ish)
      # =========================================================
      "$mainMod, h, hy3:movefocus, l"
      "$mainMod, l, hy3:movefocus, r"
      "$mainMod, k, hy3:movefocus, u"
      "$mainMod, j, hy3:movefocus, d"

      # ---------------------------------------------------------
      # HY3 TAB NAVIGATION (within a container / group)
      # ---------------------------------------------------------
      "$mainMod, bracketright, hy3:tabnext,"
      "$mainMod, bracketleft,  hy3:tabprev,"

      # Vim-ish alt option for tabbing (optional, keep if you want)
      "$mainMod, n, hy3:tabnext,"
      "$mainMod, p, hy3:tabprev,"

      # Move current tab left/right inside the tab strip
      "$mainMod SHIFT, bracketright, hy3:tabmove, r"
      "$mainMod SHIFT, bracketleft,  hy3:tabmove, l"

      # ---------------------------------------------------------
      # GROUP / CONTAINER MANAGEMENT
      # ---------------------------------------------------------
      # Make current window into a group container (or group with neighbor depending on hy3 behavior)
      "$mainMod, g, hy3:makegroup,"
      # Remove current window from group (ungroup)
      "$mainMod SHIFT, g, hy3:ungroup,"

      # Kill group (close the whole container)
      "$mainMod SHIFT, q, hy3:killgroup,"

      # ---------------------------------------------------------
      # SPLIT CONTROL (create structure intentionally)
      # ---------------------------------------------------------
      # Force next split orientation
      "$mainMod, v, hy3:split, v"
      "$mainMod, b, hy3:split, h"
      # Toggle split orientation
      "$mainMod, t, hy3:togglesplit,"

      # ---------------------------------------------------------
      # MOVE WINDOWS AROUND HY3 TREE
      # ---------------------------------------------------------
      "$mainMod SHIFT, h, hy3:movewindow, l"
      "$mainMod SHIFT, l, hy3:movewindow, r"
      "$mainMod SHIFT, k, hy3:movewindow, u"
      "$mainMod SHIFT, j, hy3:movewindow, d"

      # ---------------------------------------------------------
      # RESIZE (keep it simple + laptop friendly)
      # ---------------------------------------------------------
      # These are Hyprland core, not hy3 — but they pair well.
      "$mainMod CTRL, h, resizeactive, -40 0"
      "$mainMod CTRL, l, resizeactive,  40 0"
      "$mainMod CTRL, k, resizeactive,  0 -40"
      "$mainMod CTRL, j, resizeactive,  0  40"

      # ---------------------------------------------------------
      # FLOATING QUICK CONTROL (useful for dialogs / popups)
      # ---------------------------------------------------------
      "$mainMod, space, togglefloating,"
      "$mainMod, f, fullscreen, 1"

      # ---------------------------------------------------------
      # DEBUG / SANITY CHECKS (optional)
      # ---------------------------------------------------------
      # Reload config fast
      "$mainMod SHIFT, r, exec, hyprctl reload"
      # Show loaded plugins in a terminal (change $terminal if need
