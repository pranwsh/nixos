{ inputs, pkgs, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      plugin = [
        "${inputs.hyprland-plugins.packages.${pkgs.system}.hyprscrolling}/lib/libhyprscrolling.so"
      ];
      
      "plugin:hyprscrolling" = {
        focus_fit_method = 1;
        follow_focus = false;
        column_width = .5;
      };
    };
  };
}


