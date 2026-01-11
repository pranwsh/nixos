{ config, pkgs, inputs, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;

    plugins = [
      inputs.hy3.packages.${pkgs.system}.hy3
    ];
  };
}
