{...}: {
  services.kanshi = {
    enable = true;
    systemdTarget = "graphical-session.target";
    profiles = {
      undocked = {
        outputs = [
          {
            criteria = "eDP-1";
            status = "enable";
            mode = "1920x1080@60.164001";
            position = "0,0";
            scale = 1.0;
          }
        ];
      };
      docked = {
        outputs = [
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
      };
    };
  };
}
