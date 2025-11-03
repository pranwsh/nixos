{...}: {
  wayland.windowManager.hyprland.settings = {
    # Define variables
    "$mainMod" = "SUPER";
    "$terminal" = "kitty";
    "$browser" = "zen";
    "$menu" = "wofi --show drun";
    
    bind = [
      # Application launchers
      "$mainMod, Q, exec, $terminal"
      "$mainMod, W, exec, $browser"
      "$mainMod, E, exec, spotify"
      "$mainMod, R, exec, $menu"
      
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
      
      # Move focus with vim keys (columns)
      "$mainMod, h, layoutmsg, move -col"
      "$mainMod, l, layoutmsg, move +col"
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
      
      # Move windows between columns
      "$mainMod SHIFT, h, layoutmsg, movewindowto l"
      "$mainMod SHIFT, l, layoutmsg, movewindowto r"
      "$mainMod SHIFT, k, layoutmsg, movewindowto u"
      "$mainMod SHIFT, j, layoutmsg, movewindowto d"
      
      # Resize columns
      "$mainMod, equal, layoutmsg, colresize +.1"
      "$mainMod, minus, layoutmsg, colresize -.1"
      
      # Fit column sizes
      "$mainMod SHIFT, f, layoutmsg, fitsize active"
      "$mainMod SHIFT, g, layoutmsg, fitsize all"
      
      # Align active window
      "$mainMod SHIFT, c, layoutmsg, alignwindow center"
      
      # Scroll between columns with mouse
      "$mainMod, mouse_down, layoutmsg, move +col"
      "$mainMod, mouse_up, layoutmsg, move -col"
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
