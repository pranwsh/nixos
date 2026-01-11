# dwindle.nix
{ ... }:
{
  wayland.windowManager.hyprland.settings = {
    # Make dwindle behave more like “one obvious rule set”
    dwindle = {
      # Don’t do weird “keep my old split ratio” stuff
      preserve_split = false;

      # Default split direction is consistent (tiled feel)
      force_split = 2; # 0=off, 1=split to left/top, 2=split to right/bottom

      # Don’t randomly shrink/expand siblings when things change
      split_bias = 0;

      # Keep your “main” window stable when new windows appear
      no_gaps_when_only = false;
      special_scale_factor = 1.0;

      # If you use grouping, keep it deterministic (tabs)
      # (This is Hyprland native grouping, not hy3)
      # group_insert_after_current = true;
    };

    # Strongly recommended “predictable defaults”
    general = {
      layout = "dwindle";

      # Keep geometry changes calmer
      resize_on_border = true;
      extend_border_grab_area = 15;

      # Gaps/borders consistent
      gaps_in = 5;
      gaps_out = 10;
      border_size = 2;
    };

    # Turn off “smart” behaviors that feel random
    input = {
      follow_mouse = 0; # focus only changes when you explicitly focus
    };

    misc = {
      focus_on_activate = true;
      mouse_move_enables_dpms = true;
      vrr = 1;
    };

    # Optional: predictable split control binds (manual control)
    bind = [
      # Force split direction for the NEXT window you open
      # (layoutmsg affects dwindle)
      "$mainMod, H, layoutmsg, preselect l"
      "$mainMod, L, layoutmsg, preselect r"
      "$mainMod, K, layoutmsg, preselect u"
      "$mainMod, J, layoutmsg, preselect d"

      # Cancel preselect
      "$mainMod, escape, layoutmsg, cancelpreselect"

      # Flip / rotate for when dwindle guesses wrong
      "$mainMod, F, layoutmsg, togglesplit"
      "$mainMod, R, layoutmsg, swapwithmaster"
    ];
  };
}
