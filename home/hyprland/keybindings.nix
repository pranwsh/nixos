{...}: {
  wayland.windowManager.hyprland.settings = {
    # Define variables
    "$mainMod" = "SUPER";
    "$terminal" = "kitty";
    "$browser" = "zen";
    "$menu" = "wofi --show drun";

     bind = [
      # Fullscreen toggle
      "SUPER, comma, fullscreen, 1"   # Halfscreen (maximize, keeps gaps/bar)     
      
      # Move windows in dwindle
      "SUPER SHIFT, period, movewindow, r"
      "SUPER SHIFT, comma, movewindow, l"
      "SUPER SHIFT, up, movewindow, u"
      "SUPER SHIFT, down, movewindow, d"
      
      # Split ratio control (replaces column width cycling)
      "SUPER, bracketright, splitratio, +0.05"
      "SUPER, bracketleft, splitratio, -0.05"
      
      # Reset split ratio
      "SUPER SHIFT, F, splitratio, exact 1"
      
      # Toggle split direction
      "SUPER SHIFT, G, togglesplit,"
      
      # Preselect (for next window placement)
      "SUPER SHIFT, C, layoutmsg, preselect d"  # down
      "SUPER SHIFT, L, layoutmsg, preselect r"  # right
      "SUPER SHIFT, H, layoutmsg, preselect l"  # left

      # Application launchers
      "$mainMod, Q, exec, $terminal"
      "$mainMod, W, exec, $browser"
      "$mainMod, E, exec, spotify"
      "$mainMod, R, exec, $menu"
      "$mainMod, A, exec, chromium"
      
      # Window management
      "$mainMod, C, killactive,"
      "$mainMod, M, exit,"
      "$mainMod, V, togglefloating,"
      "$mainMod, P, pseudo,"
      
      # Move focus with arrow keys
      "$mainMod, left, movefocus, l"
      "$mainMod, right, movefocus, r"
      "$mainMod, up, movefocus, u"
      "$mainMod, down, movefocus, d"
      
      # Move focus with vim keys
      "$mainMod, h, movefocus, l"
      "$mainMod, l, movefocus, r"
      "$mainMod, j, movefocus, d"
      "$mainMod, k, movefocus, u"
      
      # Switch workspaces
      "$mainMod, 1, workspace, 1"
      "$mainMod, 2, workspace, 2"
      "$mainMod, 3, workspace, 3"
      "$mainMod, 4, workspace, 4"
      "$mainMod, 5, workspace, 5"
      "$mainMod, 6, workspace, 6"
      "$mainMod, 7, workspace, 7"
      "$mainMod, 8, workspace, 8"
      "$mainMod, 9, workspace, 9"
      "$mainMod, 0, workspace, 10"
      "$mainMod, S, togglespecialworkspace, magic"
      
      # Move windows to workspaces
      "$mainMod SHIFT, 1, movetoworkspace, 1"
      "$mainMod SHIFT, 2, movetoworkspace, 2"
      "$mainMod SHIFT, 3, movetoworkspace, 3"
      "$mainMod SHIFT, 4, movetoworkspace, 4"
      "$mainMod SHIFT, 5, movetoworkspace, 5"
      "$mainMod SHIFT, 6, movetoworkspace, 6"
      "$mainMod SHIFT, 7, movetoworkspace, 7"
      "$mainMod SHIFT, 8, movetoworkspace, 8"
      "$mainMod SHIFT, 9, movetoworkspace, 9"
      "$mainMod SHIFT, 0, movetoworkspace, 10"
      "$mainMod SHIFT, S, movetoworkspace, special:magic"
      
      # Move windows (swap positions in dwindle tree)
      "$mainMod SHIFT, h, movewindow, l"
      "$mainMod SHIFT, l, movewindow, r"
      "$mainMod SHIFT, k, movewindow, u"
      "$mainMod SHIFT, j, movewindow, d"
      
      # Adjust split ratios (replaces column resize)
      "$mainMod, equal, splitratio, +0.05"
      "$mainMod, minus, splitratio, -0.05"
      
      # Reset split ratio & toggle split
      "$mainMod SHIFT, f, splitratio, exact 1"
      "$mainMod SHIFT, g, togglesplit,"
      
      # Preselect next window position
      "$mainMod SHIFT, c, layoutmsg, preselect d"
      
      # Mouse binds for split ratio (replaces column navigation)
      "$mainMod, mouse_down, splitratio, -0.05"
      "$mainMod, mouse_up, splitratio, +0.05"
    ];   
    
    bindm = [
      "$mainMod, mouse:272, movewindow"
      "$mainMod, mouse:273, resizewindow"
    ];
    
    bindel = [
      ",XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
      ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
      ",XF86MonBrightnessUp, exec, brightnessctl s 10%+"
      ",XF86MonBrightnessDown, exec, brightnessctl s 10%-"
    ];
    
    bindl = [
      ", XF86AudioNext, exec, playerctl next"
      ", XF86AudioPause, exec, playerctl play-pause"
      ", XF86AudioPlay, exec, playerctl play-pause"
      ", XF86AudioPrev, exec, playerctl previous"
    ];
  };
}
