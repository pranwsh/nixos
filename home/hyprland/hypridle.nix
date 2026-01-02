{ config, pkgs, ... }:

{
  home.packages = [
    pkgs.hypridle
    pkgs.hyprlock
  ];

  # --- Hyprlock config (basic, tweak as you want) ---
  xdg.configFile."hypr/hyprlock.conf".text = ''
    general {
      ignore_empty_input = true
    }

    background {
      color = rgba(0,0,0,0.85)
    }

    input-field {
      size = 300, 60
      outline_thickness = 2
      dots_size = 0.2
      dots_spacing = 0.35
      dots_center = true
      placeholder_text = "Password"
      fade_on_empty = true
    }

    label {
      text = $TIME
      font_size = 64
      position = 0, 120
      halign = center
      valign = center
    }
  '';

  # --- Hypridle config ---
  xdg.configFile."hypr/hypridle.conf".text = ''
    general {
      lock_cmd = ${pkgs.hyprlock}/bin/hyprlock
      before_sleep_cmd = ${pkgs.hyprlock}/bin/hyprlock
      after_sleep_cmd = ${pkgs.hyprland}/bin/hyprctl dispatch dpms on
    }

    listener {
      timeout = 300
      on-timeout = ${pkgs.hyprlock}/bin/hyprlock
    }

    listener {
      timeout = 120
      on-timeout = ${pkgs.hyprland}/bin/hyprctl dispatch dpms off
      on-resume = ${pkgs.hyprland}/bin/hyprctl dispatch dpms on
    }

    listener {
      timeout = 120
      on-timeout = ${pkgs.systemd}/bin/systemctl suspend
    }
  '';

  wayland.windowManager.hyprland.settings.exec-once = [
    "${pkgs.hypridle}/bin/hypridle"
  ];
}
