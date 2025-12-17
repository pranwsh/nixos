{ config, pkgs, lib, ... }:

let
  theme = import ../style.nix;

  toHex2 = n:
    let s = lib.toHexString n;
    in if builtins.stringLength s == 1 then "0${s}" else s;

  rgbHex = c: "#${toHex2 c.r}${toHex2 c.g}${toHex2 c.b}";
in
{
  xdg.configFile."nvim/lua/theme/colors.lua".text = ''
    return {
      bg     = "${rgbHex theme.colors.bg}",
      fg     = "${rgbHex theme.colors.fg}",
      accent = "${rgbHex theme.colors.accent}",
      red    = "${rgbHex theme.colors.red}",
      green  = "${rgbHex theme.colors.green}",
      yellow = "${rgbHex theme.colors.yellow}",
      opacity_bg = ${toString theme.opacity.bg},
    }
  '';
}
