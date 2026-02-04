{pkgs, ...}: {
  home.packages = with pkgs; [
    bibata-cursors
  ];

  home.sessionVariables = {
    XCURSOR_THEME = "Bibata-Modern-Classic";
    XCURSOR_SIZE = "18";
  };

  gtk = {
    enable = true;
    cursorTheme = {
      name = "Bibata-Modern-Classic";
      size = 18;
    };
  };
}
