{ ... }: {
  wayland.windowManager.hyprland.settings = {
    master = {
      new_status = "master";
    };

    windowrule = [
      "suppress_event maximize, match:class .*"
      "no_initial_focus on, match:class ^$, match:title ^$, match:xwayland 1, match:float 1, match:fullscreen 0, match:pin 0"
      "opacity 0.82, match:class ^(Spotify)$"
    ];
  };
}
