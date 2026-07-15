{ ... }:
{
  services.kanshi = {
    enable = true;
    systemdTarget = "hyprland-session.target";
    settings = [
      {
        profile.name = "docked";
        profile.outputs = [
          {
            criteria = "HDMI-A-1";
            mode = "2560x1080@60Hz";
            status = "enable";
          }
          {
            criteria = "eDP-1";
            status = "disable";
          }
        ];
      }
      {
        profile.name = "undocked";
        profile.outputs = [
          {
            criteria = "eDP-1";
            mode = "1920x1080@60Hz";
            status = "enable";
          }
        ];
      }
    ];
  };

  wayland.windowManager.hyprland.settings.monitor = [
    "eDP-1,preferred,auto,1"
    "HDMI-A-1,disable"
  ];
}
