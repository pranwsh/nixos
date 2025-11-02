{...}: {
  wayland.windowManager.hyprland.settings = {
    plugin = {
      hyprscrolling = {
        column_default_width = "onehalf";
        column_widths = "onehalf onethird twothirds onefourth";
      };
    };
    
    # Keybindings for hyprscrolling features
    bind = [
      # Cycle through column widths
      "SUPER, bracketright, hyprscrolling:columnsize, +1"
      "SUPER, bracketleft, hyprscrolling:columnsize, -1"
      
      # Fit columns on screen
      "SUPER SHIFT, G, hyprscrolling:fitsize, active"
      "SUPER SHIFT, F, hyprscrolling:fitsize, all"
      
      # Align window in column
      "SUPER SHIFT, C, hyprscrolling:alignwindow, center"
      "SUPER SHIFT, L, hyprscrolling:alignwindow, right"
      "SUPER SHIFT, H, hyprscrolling:alignwindow, left"
    ];
    
    # Mouse bindings for workspace scrolling
    bindm = [
      "SUPER, mouse_down, hyprscrolling:workspace, e+1"
      "SUPER, mouse_up, hyprscrolling:workspace, e-1"
    ];
  };
}
