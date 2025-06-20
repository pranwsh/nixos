{ inputs, pkgs, lib, ... }: {
  imports = [
    inputs.stylix.homeModules.stylix
  ];

  stylix = {
    enable = true;

    # Base16 color scheme - you can change this to any base16 scheme
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-medium.yaml";

    # Or use an image to generate colors automatically
    # image = ./wallpapers/macblue;

    base16Scheme = {
      base00 = "000000";  # Default Background
      base01 = "1a1a1a";  # Lighter Background (status bars)
      base02 = "2d2d2d";  # Selection Background
      base03 = "404040";  # Comments, Invisibles
      base04 = "666666";  # Dark Foreground (status bars)
      base05 = "cccccc";  # Default Foreground
      base06 = "e0e0e0";  # Light Foreground (not often used)
      base07 = "ffffff";  # Light Background (not often used)
      base08 = "e84f85";  # Red/Pink
      base09 = "e8784f";  # Orange
      base0A = "f4d03f";  # Yellow
      base0B = "58d68d";  # Green
      base0C = "5dade2";  # Cyan
      base0D = "5d8cff";  # Blue
      base0E = "af7dff";  # Magenta/Purple
      base0F = "8b4513";  # Brown
    };


    # Font configuration
    # fonts = {
    #   monospace = {
    #     package = pkgs.jetbrains-mono;
    #     name = "JetBrains Mono";
    #   };
    #   sansSerif = {
    #     package = pkgs.dejavu_fonts;
    #     name = "DejaVu Sans";
    #   };
    #   serif = {
    #     package = pkgs.dejavu_fonts;
    #     name = "DejaVu Serif";
    #   };
    # };

    # Configure what gets themed
    targets = {
      gtk.enable = true;
      kitty.enable = true;
      hyprland.enable = false;
    };

    # Cursor theme
    # cursor = {
    #   package = pkgs.bibata-cursors;
    #   name = "Bibata-Modern-Classic";
    #   size = 24;
    # };

  };
}
