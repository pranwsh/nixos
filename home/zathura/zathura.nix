{ config, pkgs, lib, ... }:

let
  # Customizable colors - adjust these to your preference
  backgroundColor = "#000000";
  foregroundColor = "#ffffff";
  accentColor = "#7aa2f7";
  errorColor = "#f7768e";
  
  # Alpha transparency setting (0.0 to 1.0) - applies to ALL backgrounds
  alpha = .6;
  
  # Convert hex to RGB values for alpha transparency
  hexToRgb = hex:
    let
      cleaned = lib.removePrefix "#" (lib.toLower hex);
      hexToDec = h: 
        let
          chars = lib.stringToCharacters h;
          vals = map (c: 
            if c == "0" then 0 else if c == "1" then 1
            else if c == "2" then 2 else if c == "3" then 3
            else if c == "4" then 4 else if c == "5" then 5
            else if c == "6" then 6 else if c == "7" then 7
            else if c == "8" then 8 else if c == "9" then 9
            else if c == "a" then 10 else if c == "b" then 11
            else if c == "c" then 12 else if c == "d" then 13
            else if c == "e" then 14 else if c == "f" then 15
            else 0
          ) chars;
        in
          (builtins.elemAt vals 0) * 16 + (builtins.elemAt vals 1);
      r = hexToDec (builtins.substring 0 2 cleaned);
      g = hexToDec (builtins.substring 2 2 cleaned);
      b = hexToDec (builtins.substring 4 2 cleaned);
    in
      { inherit r g b; };
  
  # Convert background color to RGBA
  rgb = hexToRgb backgroundColor;
  bgColorRgba = "rgba(${toString rgb.r},${toString rgb.g},${toString rgb.b},${toString alpha})";

in
{
  programs.zathura = {
    enable = true;
    
    options = {

      selection-clipboard = "clipboard";

      # Hide the statusbar
      guioptions = "none";
      
      # Allow recolor
      recolor = true;
      
      # Don't allow original hue when recoloring
      recolor-keephue = false;
      
      # Don't keep original image colors while recoloring
      recolor-reverse-video = false;
      
      # Command line completion entries
      completion-fg = foregroundColor;
      completion-bg = bgColorRgba;
      
      # Command line completion group elements
      completion-group-fg = accentColor;
      completion-group-bg = bgColorRgba;
      
      # Current command line completion element
      completion-highlight-fg = backgroundColor;
      completion-highlight-bg = foregroundColor;
      
      # Default foreground/background color
      default-bg = bgColorRgba;
      
      # Input bar
      inputbar-fg = foregroundColor;
      inputbar-bg = bgColorRgba;
      
      # Notification
      notification-fg = foregroundColor;
      notification-bg = bgColorRgba;
      
      # Error notification
      notification-error-fg = foregroundColor;
      notification-error-bg = errorColor;
      
      # Warning notification
      notification-warning-fg = foregroundColor;
      notification-warning-bg = errorColor;
      
      # Status bar
      statusbar-fg = foregroundColor;
      statusbar-bg = bgColorRgba;
      
      # Highlighting parts of the document
      highlight-color = accentColor;
      highlight-active-color = accentColor;
      
      # Represent light/dark colors in recoloring mode
      recolor-lightcolor = "rgba(0,0,0,0)";
      recolor-darkcolor = foregroundColor;
      
      # 'Loading...' text
      render-loading-fg = foregroundColor;
      render-loading-bg = bgColorRgba;
      
      # Index mode
      index-fg = foregroundColor;
      index-bg = bgColorRgba;
      
      # Selected element in index mode
      index-active-fg = backgroundColor;
      index-active-bg = foregroundColor;
    };
    
    # Additional settings can be added here
    extraConfig = ''
      # Add any additional zathura settings here
    '';
  };
}
