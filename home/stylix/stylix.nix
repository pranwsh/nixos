{ inputs, pkgs, ... }: {
  imports = [
    inputs.stylix.homeManagerModules.stylix
  ];

  stylix = {
    enable = true;

    # Base16 color scheme - you can change this to any base16 scheme
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-medium.yaml";
    
    # Or use an image to generate colors automatically
    image = ./wallpapers/macdull;

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
    };

    # Cursor theme
    # cursor = {
    #   package = pkgs.bibata-cursors;
    #   name = "Bibata-Modern-Classic";
    #   size = 24;
    # };

  };
}
