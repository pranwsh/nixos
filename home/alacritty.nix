
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
      window = {
        opacity = lib.mkForce "${style.opacity.bg}";
        decorations = "full";
        dynamic_padding = true;
      };

      bell = {
        enabled = false;
      };

      colors = {
        primary = {
          background = "#282a36";
          foreground = "#f8f8f2";
        };

        selection = {
          text = "#f8f8f2";
          background = "#44475a";
        };

        cursor = {
          text = "#282a36";
          cursor = "#f8f8f2";
        };

        normal = {
          black   = "#282a36";
          red     = "#af85f5";
          green   = "#50fa7b";
          yellow  = "#f1fa8c";
          blue    = "#bd93f9";
          magenta = "#ff79c6";
          cyan    = "#8be9fd";
          white   = "#f8f8f2";
        };

        bright = {
          black   = "#6272a4";
          red     = "#ff5555";
          green   = "#50fa7b";
          yellow  = "#f1fa8c";
          blue    = "#bd93f9";
          magenta = "#ff79c6";
          cyan    = "#8be9fd";
          white   = "#ff79c6";
        };
      };
    };
  };
}
