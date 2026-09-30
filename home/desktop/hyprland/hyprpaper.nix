{
  config,
  ...
}:
let
  wp = toString config.style.wallpaperPath;
in
{
  services.hyprpaper = {
    enable = true;
    systemdTarget = "hyprland-session.target";
    settings = {
      ipc = true;
      splash = false;

      preload = [ wp ];

      wallpaper = [
        {
          monitor = "eDP-1";
          path = wp;
          fit_mode = "cover";
        }
        {
          monitor = "HDMI-A-1";
          path = wp;
          fit_mode = "cover";
        }
      ];
    };
  };
}
