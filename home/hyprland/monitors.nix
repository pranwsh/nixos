{pkgs, ...}: let
  monitorScript = pkgs.writeShellScriptBin "hypr-monitor-switch" ''
    handle() {
      case "$1" in
        monitoradded*)
          hyprctl keyword monitor "HDMI-A-1,preferred,auto,1"
          hyprctl keyword monitor "eDP-1,disable"
          ;;
        monitorremoved*)
          hyprctl keyword monitor "eDP-1,preferred,auto,1"
          ;;
      esac
    }

    socat - "UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" \
      | while read -r line; do handle "$line" && sleep 0.1; done
  '';
in {
  home.packages = [pkgs.socat];

  wayland.windowManager.hyprland.settings.monitor = [
    "eDP-1,preferred,auto,1"
    "HDMI-A-1,preferred,auto,1"
  ];

  wayland.windowManager.hyprland.settings.exec-once = [
    "${monitorScript}/bin/hypr-monitor-switch"
  ];
}
