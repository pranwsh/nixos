{ ... }: {
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = [ "zen-beta.desktop" ];
      "x-scheme-handler/http" = [ "zen-beta.desktop" ];
      "x-scheme-handler/https" = [ "zen-beta.desktop" ];
      "x-scheme-handler/about" = [ "zen-beta.desktop" ];
      "x-scheme-handler/unknown" = [ "zen-beta.desktop" ];
      "application/pdf" = [ "org.pwmt.zathura.desktop" ];
    };
  };
}
