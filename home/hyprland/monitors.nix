{pkgs, ...}: let
  monitorScript = pkgs.writeShellScriptBin "hypr-monitor-switch" ''
    export PATH=${pkgs.hyprland}/bin:${pkgs.socat}/bin:$PATH

    # Handle monitor already connected at startup
    sleep 2
    if ${pkgs.hyprland}/bin/hyprctl monitors | grep -q "HDMI-A-1"; then
      ${pkgs.hyprland}/bin/hyprctl keyword monitor "HDMI-A-1,preferred,auto,1"
      ${pkgs.hyprland}/bin/hyprctl keyword monitor "eDP-1,disable"
    fi

    handle() {
      case "$1" in
        monitoradded*)
          sleep 1
          ${pkgs.hyprland}/bin/hyprctl keyword monitor "HDMI-A-1,preferred,auto,1"
          ${pkgs.hyprland}/bin/hyprctl keyword monitor "eDP-1,disable"
          ;;
        monitorremoved*)
          sleep 1
          ${pkgs.hyprland}/bin/hyprctl keyword monitor "eDP-1,preferred,auto,1"
          ;;
      esac
    }

    socat - "UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" \
      | while read -r line; do handle "$line"; done
  '';
in {
  home.packages = [pkgs.socat];
  wayland.windowManager.hyprland.settings.monitor = [
    "eDP-1,preferred,auto,1"
    "HDMI-A-1,disable"
  ];
  wayland.windowManager.hyprland.settings.exec-once = [
    "${monitorScript}/bin/hypr-monitor-switch"
  ];
}
