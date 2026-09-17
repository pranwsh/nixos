# Central styling module.
#
# Owns style.wallpaperPath + the derived 16-color palette. Consumers
# (hyprpaper, hyprland, wofi, gtk, …) only ever read config.style —
# they never invoke pywal themselves, keeping them decoupled from how
# the palette is produced.
#
# How regeneration works: when style.enablePywal is true, palette.nix
# runs pywal16 at evaluation time on the wallpaper store path. Changing
# the wallpaper file changes its store hash, so the next rebuild
# automatically regenerates color0..color15 — no daemon, no manual step,
# and style.nix source is never rewritten. Set enablePywal = false to
# pin the fallback palette in fallback.nix.
{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.style;

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

  fallback = import ./fallback.nix;

  # Lazy: only evaluated (and built) when enablePywal is true.
  palette =
    if cfg.enablePywal then
      import ./palette.nix {
        inherit pkgs;
        wallpaper = cfg.wallpaperPath;
        backend = cfg.pywalBackend;
      }
    else
      null;

  colors = if palette != null then palette.colors else fallback;
in
{
  options.style = {
    wallpaperPath = lib.mkOption {
      type = lib.types.path;
      default = ../../wallpapers/blue;
      description = "Wallpaper image pywal generates the palette from and hyprpaper displays.";
    };

    enablePywal = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Generate color0..color15 from wallpaperPath at evaluation time. Disable to pin the fallback palette.";
    };

    pywalBackend = lib.mkOption {
      type = lib.types.str;
      default = "wal";
      description = "pywal16 color backend (wal, colorthief, haishoku, schemer2, …). 'wal' works headless in the sandbox.";
    };

    opacity = lib.mkOption {
      type = lib.types.number;
      default = 0.65;
      description = "Default opacity consumed by terminal / bar / launcher configs.";
    };

    background = lib.mkOption {
      type = lib.types.str;
      default = "#000000";
      description = "Hand-set background. Never derived from pywal.";
    };

    backgroundRgb = lib.mkOption {
      type = lib.types.str;
      description = "background as R,G,B for configs that need rgb() triplets.";
    };

    foreground = lib.mkOption {
      type = lib.types.str;
      default = "#cdd2f4";
      description = "Hand-set foreground. Never derived from pywal.";
    };

    foregroundRgb = lib.mkOption {
      type = lib.types.str;
      description = "foreground as R,G,B for configs that need rgb() triplets.";
    };

    colors = lib.mkOption {
      type = lib.types.attrsOf lib.types.str;
      description = "16-color palette (color0..color15) from pywal, or fallback when enablePywal is false.";
    };
  };

  config.style = {
    inherit colors;
    backgroundRgb = hexToRgb cfg.background;
    foregroundRgb = hexToRgb cfg.foreground;
  };
}
