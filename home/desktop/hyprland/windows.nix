{ ... }:
{
  wayland.windowManager.hyprland.settings = {
    config = {
      master = {
        new_status = "master";
      };
    };

    window_rule = [
      {
        match = {
          class = ".*";
        };
        suppress_event = "maximize";
      }
      {
        match = {
          class = "^$";
          title = "^$";
          xwayland = true;
          float = true;
          fullscreen = false;
          pin = false;
        };
        no_focus = true;
      }
      {
        match = {
          class = "^(Spotify)$";
        };
        opacity = 0.82;
      }
    ];
  };
}
