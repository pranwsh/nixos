{pkgs, ...}: {
  # Install hyprshot
  home.packages = with pkgs; [
    hyprshot
  ];

  # Create the Screenshots directory
  home.file."Pictures/Screenshots/.keep".text = "";

  # Configure screenshot keybindings
  wayland.windowManager.hyprland.settings = {
    bind = [
      # Capture full screen
      "SUPER, Z, exec, ${pkgs.hyprshot}/bin/hyprshot -m output -o ~/Pictures/Screenshots"
      
      # Capture focused window
      "SUPER SHIFT, Z, exec, ${pkgs.hyprshot}/bin/hyprshot -m window -o ~/Pictures/Screenshots"
      
      # Capture a selected region
      "SUPER CTRL, Z, exec, ${pkgs.hyprshot}/bin/hyprshot -m region -o ~/Pictures/Screenshots"
    ];
  };
}
