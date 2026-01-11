{...}: {
  wayland.windowManager.hyprland.settings = {
    cursor = {
      no_hardware_cursors = true;
    };

    env = [
      # "XCURSOR_THEME,Bibata-Modern-Classic"
      # "XCURSOR_SIZE,18"
    ];

    general = {
      gaps_in = 8;
      gaps_out = 16;
      border_size = 0;
      "col.active_border" = "rgba(ff800044)";
      "col.inactive_border" = "rgba(ffcd9c22)";
      resize_on_border = true;
      allow_tearing = false;
      layout = "hy3";
    };

    decoration = {
      rounding = 30;
      active_opacity = 1.0;
      inactive_opacity = 1.0;

      shadow = {
        enabled = false;
        range = 4;
        render_power = 3;
        color = "rgba(1a1a1aee)";
      };

      blur = {
        enabled = true;
        size = 4;
        passes = 3;
        vibrancy = 0;
      };
    };

    animations = {
      enabled = true;

      bezier = [
        "easeOutQuint,0.23,1,0.32,1"
        "easeInOutCubic,0.65,0.05,0.36,1"
        "linear,0,0,1,1"
        "almostLinear,0.5,0.5,0.75,1.0"
        "quick,0.15,0,0.1,1"
        "overshot,0.13,0.99,0.29,1"
      ];

      animation = [
        "windows,1,6,overshot,slide"
        "border,1,10,default"
        "fade,1,10,default"
        "workspaces,1,7,overshot,slide"
      ];
    };

    input = {
      kb_layout = "us";
      kb_variant = "";
      kb_model = "";
      kb_options = "";
      kb_rules = "";
      follow_mouse = 1;
      sensitivity = 0;

      touchpad = {
        natural_scroll = false;
        disable_while_typing=false;
      };
    };

    gestures = {
      gesture = "3, horizontal, workspace";
      workspace_swipe_min_speed_to_force = 5;
      workspace_swipe_invert = true;
    };

    device = [
    {
      name = "epic-mouse-v1";
      sensitivity = -0.5;
    }
    {
      name = "kingston-hyperx-pulsefire-core";
      sensitivity = -0.6;
    }
    ];

    misc = {
      force_default_wallpaper = -1;
      disable_hyprland_logo = true;
    };

    ecosystem = {
      no_update_news = true;
      no_donation_nag = true;
    };
  };
}
