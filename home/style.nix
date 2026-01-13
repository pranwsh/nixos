{ config, lib, pkgs, ... }:

let
  wallpaperPath = ./wallpapers/idks-nix.png;
  
  base_colors = {
    bg = { r = 0; g = 0; b = 0; };
    fg = { r = 205; g = 214; b = 244; };
    accent = { r = 0; g = 0; b = 0; };
  };
  opacity = {
    bg = 0.6;
    fg = 1.0;
    accent = 0.4;
  };
in
{
  options.style = lib.mkOption {
    type = lib.types.attrs;
    default = {};
  };

  config.style = {
    inherit base_colors opacity wallpaperPath;
    rgba = {
      background = "rgba(${toString base_colors.bg.r},${toString base_colors.bg.g},${toString base_colors.bg.b},${toString opacity.bg})";
      foreground = "rgba(${toString base_colors.fg.r},${toString base_colors.fg.g},${toString base_colors.fg.b},${toString opacity.fg})";
      accent = "rgba(${toString base_colors.accent.r},${toString base_colors.accent.g},${toString base_colors.accent.b},${toString opacity.accent})";
    };
  };
}
