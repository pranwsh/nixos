{ ... }:
{
  wayland.windowManager.hyprland.settings = {
    window_rule = [
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