{ lib, config, ... }:
let
  hexDigits = {
    "0" = 0;
    "1" = 1;
    "2" = 2;
    "3" = 3;
    "4" = 4;
    "5" = 5;
    "6" = 6;
    "7" = 7;
    "8" = 8;
    "9" = 9;
    "a" = 10;
    "b" = 11;
    "c" = 12;
    "d" = 13;
    "e" = 14;
    "f" = 15;
    "A" = 10;
    "B" = 11;
    "C" = 12;
    "D" = 13;
    "E" = 14;
    "F" = 15;
  };
  dec = s: hexDigits.${builtins.substring 0 1 s} * 16 + hexDigits.${builtins.substring 1 1 s};
  hexToRgb =
    hex:
    let
      h = lib.removePrefix "#" hex;
    in
    "${toString (dec (builtins.substring 0 2 h))},${toString (dec (builtins.substring 2 2 h))},${
      toString (dec (builtins.substring 4 2 h))
    }";
in
{
  options.style = lib.mkOption {
    type = lib.types.attrs;
    default = { };
  };

  config.style = {
    wallpaperPath = ../wallpapers/grass;

    background = "#000000";
    backgroundRgb = hexToRgb config.style.background;
    foreground = "#cdd2f4";
    foregroundRgb = hexToRgb config.style.foreground;
    opacity = 0.65;

    colors = {
      color0 = "#282a36";
      color1 = "#ff5555";
      color2 = "#50fa7b";
      color3 = "#f1fa8c";
      color4 = "#bd93f9";
      color5 = "#ff79c6";
      color6 = "#8be9fd";
      color7 = "#f8f8f2";
      color8 = "#6272a4";
      color9 = "#ff6e6e";
      color10 = "#69ff94";
      color11 = "#ffffa5";
      color12 = "#d6acff";
      color13 = "#ff92df";
      color14 = "#a4ffff";
      color15 = "#cdd2f4";
    };
  };
}
