{pkgs, ...}: {

  home.packages = with pkgs; [
    hyprshot
  ];

  home.file."Pictures/Screenshots/.keep".text = "";

  wayland.windowManager.hyprland.settings = {
    bind = [
      "SUPER, Z, exec, ${pkgs.hyprshot}/bin/hyprshot -m output -o ~/Pictures/Screenshots"
      
      "SUPER SHIFT, Z, exec, ${pkgs.hyprshot}/bin/hyprshot -m window -o ~/Pictures/Screenshots"
      
      "SUPER CTRL, Z, exec, ${pkgs.hyprshot}/bin/hyprshot -m region -o ~/Pictures/Screenshots"
    ];
  };
}
