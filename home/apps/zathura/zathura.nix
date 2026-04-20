{...}: {
  programs.zathura = {
    enable = true;
    options = {
      selection-clipboard = "clipboard";
      guioptions = "none";
      recolor = true;
      recolor-lightcolor = "rgba(0,0,0,0.6)";
      recolor-darkcolor = "#ffffff";
      default-bg = "rgba(0,0,0,0)";

      # Lock PDF to window width
      # adjust-open = "width";
      zoom = "width";

      # Disable mouse wheel zooming
      mouse-wheel-zoom = "false";
      mouse-wheel-full-page-zoom = "false";
    };

    # Disable keyboard shortcuts that would change zoom/resize the PDF
    extraConfig = ''
      unmap +
      unmap -
      unmap =
          map <C-=> noop
          map <C--> noop
    '';
  };
}
