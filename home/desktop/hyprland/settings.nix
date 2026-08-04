{ ... }: {
  wayland.windowManager.hyprland.settings = {
    config = {
      cursor = {
        no_hardware_cursors = 0;
      };

      general = {
        gaps_in = 8;
        gaps_out = 16;
        border_size = 0;
        col = {
          active_border = "rgba(ff800044)";
          inactive_border = "rgba(ffcd9c22)";
        };
        resize_on_border = true;
        extend_border_grab_area = 15;
        allow_tearing = false;
        layout = "dwindle";
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
          disable_while_typing = false;
        };
      };

      gestures = {
        workspace_swipe_min_speed_to_force = 5;
        workspace_swipe_invert = true;
      };

      misc = {
        focus_on_activate = true;
        mouse_move_enables_dpms = true;
        vrr = 1;
        force_default_wallpaper = -1;
        disable_hyprland_logo = true;
      };

      ecosystem = {
        no_update_news = true;
        no_donation_nag = true;
      };
    };

    env = [
      {
        _args = [
          "XCURSOR_THEME"
          "Bibata-Modern-Classic"
        ];
      }
      {
        _args = [
          "XCURSOR_SIZE"
          "18"
        ];
      }
    ];

    curve = [
      {
        _args = [
          "easeOutQuint"
          {
            type = "bezier";
            points = [
              [
                0.23
                1
              ]
              [
                0.32
                1
              ]
            ];
          }
        ];
      }
      {
        _args = [
          "easeInOutCubic"
          {
            type = "bezier";
            points = [
              [
                0.65
                0.05
              ]
              [
                0.36
                1
              ]
            ];
          }
        ];
      }
      {
        _args = [
          "linear"
          {
            type = "bezier";
            points = [
              [
                0
                0
              ]
              [
                1
                1
              ]
            ];
          }
        ];
      }
      {
        _args = [
          "almostLinear"
          {
            type = "bezier";
            points = [
              [
                0.5
                0.5
              ]
              [
                0.75
                1
              ]
            ];
          }
        ];
      }
      {
        _args = [
          "quick"
          {
            type = "bezier";
            points = [
              [
                0.15
                0
              ]
              [
                0.1
                1
              ]
            ];
          }
        ];
      }
      {
        _args = [
          "overshot"
          {
            type = "bezier";
            points = [
              [
                0.13
                0.99
              ]
              [
                0.29
                1
              ]
            ];
          }
        ];
      }
    ];

    animation = [
      {
        leaf = "windows";
        enabled = true;
        speed = 6;
        bezier = "overshot";
        style = "slide";
      }
      {
        leaf = "border";
        enabled = true;
        speed = 10;
        bezier = "default";
      }
      {
        leaf = "fade";
        enabled = true;
        speed = 10;
        bezier = "default";
      }
      {
        leaf = "workspaces";
        enabled = true;
        speed = 7;
        bezier = "overshot";
        style = "slide";
      }
    ];

    gesture = [
      {
        fingers = 3;
        direction = "horizontal";
        action = "workspace";
      }
    ];

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
  };
}
