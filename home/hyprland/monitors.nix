{pkgs, ...}: {
  services.kanshi = {
    enable = true;
    settings = [
      {
        profile.name = "undocked";
        profile.outputs = [
          {
            criteria = "eDP-1";
            status = "enable";
            mode = "1920x1080@60.164001";
            position = "0,0";
            scale = 1.0;
          }
        ];
        profile.exec = [
          "${pkgs.hyprland}/bin/hyprctl keyword monitor eDP-1,1920x1080@60,0x0,1"
          "${pkgs.hyprland}/bin/hyprctl dispatch dpms on"
        ];
      }
      {
        profile.name = "docked";
        profile.outputs = [
          {
            criteria = "eDP-1";
            status = "disable";
            position = "-1920,0";
          }
          {
            criteria = "HDMI-A-1";
            mode = "2560x1080@60.000000";
            position = "0,0";
            scale = 1.0;
          }
        ];
        profile.exec = [
          "${pkgs.hyprland}/bin/hyprctl keyword monitor eDP-1,disabled"
        ];
      }
    ];
  };
}
