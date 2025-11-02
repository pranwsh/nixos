{...}: {
  wayland.windowManager.hyprland.settings = {
    # Use hyprscrolling's column layout instead of dwindle
    general = {
      layout = "column";  # This activates hyprscrolling
    };
    #
    # Master layout configuration (backup/alternative)
    master = {
      new_status = "master";
    };
    
    # Window rules
    windowrulev2 = [
      "suppressevent maximize, class:.*"
      "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
      # "opacity 0.42,class:^(org\.pwmt\.zathura)$"
      "opacity 0.82,class:^(Spotify)$"
    ];
  };
}
