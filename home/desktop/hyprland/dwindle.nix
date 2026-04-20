# dwindle.nix
{ ... }:
{
  wayland.windowManager.hyprland.settings = {
    dwindle = {
      preserve_split = false;

      force_split = 2;

      split_bias = 0;

      no_gaps_when_only = false;
      special_scale_factor = 1.0;
    };

    general = {
      layout = "dwindle";

      resize_on_border = true;
      extend_border_grab_area = 15;

      gaps_in = 5;
      gaps_out = 10;
      border_size = 2;
    };

    input = {
      follow_mouse = 0;
    };

    misc = {
      focus_on_activate = true;
      mouse_move_enables_dpms = true;
      vrr = 1;
    };

    bind = [
      "$mainMod, H, layoutmsg, preselect l"
      "$mainMod, L, layoutmsg, preselect r"
      "$mainMod, K, layoutmsg, preselect u"
      "$mainMod, J, layoutmsg, preselect d"

      "$mainMod, escape, layoutmsg, cancelpreselect"

      "$mainMod, F, layoutmsg, togglesplit"
      "$mainMod, R, layoutmsg, swapwithmaster"
    ];
  };
}
