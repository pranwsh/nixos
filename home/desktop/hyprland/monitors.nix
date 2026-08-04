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
            mode = "2560x1080@74.99Hz";
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
    {
      output = "eDP-1";
      mode = "preferred";
      position = "auto";
      scale = 1;
    }
    {
      output = "HDMI-A-1";
      disabled = true;
    }
  ];
}
