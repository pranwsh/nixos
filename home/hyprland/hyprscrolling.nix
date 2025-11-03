{...}: {
  wayland.windowManager.hyprland.settings = {
    plugin = {
      hyprscrolling = {
        fullscreen_on_one_column = true;
        focus_fit_method = 1;
      };
    };
    
    # Corrected keybindings using layoutmsg
    bind = [
      # Move between columns
      "SUPER, period, layoutmsg, move +col"
      "SUPER, comma, layoutmsg, move -col"
      
      # Move windows between columns
      "SUPER SHIFT, period, layoutmsg, movewindowto r"
      "SUPER SHIFT, comma, layoutmsg, movewindowto l"
      "SUPER SHIFT, up, layoutmsg, movewindowto u"
      "SUPER SHIFT, down, layoutmsg, movewindowto d"
      
      # Cycle column widths
      "SUPER, bracketright, layoutmsg, cyclewidth +1"
      "SUPER, bracketleft, layoutmsg, cyclewidth -1"
      
      # Fit columns
      "SUPER SHIFT, F, layoutmsg, fitsize all"
      "SUPER SHIFT, G, layoutmsg, fitsize active"
      
      # Align windows
      "SUPER SHIFT, C, layoutmsg, alignwindow center"
      "SUPER SHIFT, L, layoutmsg, alignwindow right"
      "SUPER SHIFT, H, layoutmsg, alignwindow left"
    ];
  };
}
