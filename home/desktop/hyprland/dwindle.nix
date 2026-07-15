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
