{ config, pkgs, lib, ... }:
let
  style = import ./style.nix;
in 
{
  home.packages = with pkgs; [
    alacritty
  ];
  
  programs.alacritty = {
    enable = true;
    settings = {
      # Window settings
      window = {
        opacity = lib.mkForce (builtins.fromJSON style.opacity.bg);
      };
      
      # Bell settings - use lowercase for the variant
      bell = {
        animation = "EaseOutExpo";
        duration = 0;
      };
      
      # Font settings - needed for special characters in bash prompt
      font = {
        size = 11.0;
        normal = {
          family = "monospace";
          style = "Regular";
        };
      };
      
      # Colors (Dracula-inspired theme matching your Kitty config)
      colors = {
        primary = {
          background = "#282a36";
          foreground = "#f8f8f2";
        };
        
        cursor = {
          text = "#282a36";
          cursor = "#f8f8f2";
        };
        
        selection = {
          text = "#f8f8f2";
          background = "#44475a";
        };
        
        normal = {
          black = "#282a36";
          red = "#af85f5";
          green = "#50fa7b";
          yellow = "#f1fa8c";
          blue = "#bd93f9";
          magenta = "#ff79c6";
          cyan = "#8be9fd";
          white = "#f8f8f2";
        };
        
        bright = {
          black = "#6272a4";
          red = "#ff5555";
          green = "#50fa7b";
          yellow = "#f1fa8c";
          blue = "#bd93f9";
          magenta = "#ff79c6";
          cyan = "#8be9fd";
          white = "#ff79c6";
        };
      };
    };
  };
}
