{ config, pkgs, lib, walNix, ... }:

let
  theme = import ./style.nix;
  c = (import "${walNix}/colors.nix").colorscheme;

in 
{
  home.packages = with pkgs; [
    kitty
    fish
  ];

  programs.kitty = {
    enable = true;

    settings = {
      enable_audio_bell = "no";
      background_opacity = lib.mkForce (toString theme.opacity.bg);
      confirm_os_window_close = "0";
      cursor_trail = "1";
    };

    extraConfig = ''
      foreground ${c.foreground}
      background #000000
      cursor     ${c.cursor}

      selection_foreground ${c.foreground}
      selection_background ${c.color8}
      url_color ${c.color6}

      color0  ${c.color0}
      color1  ${c.color1}
      color2  ${c.color2}
      color3  ${c.color3}
      color4  ${c.color4}
      color5  ${c.color5}
      color6  ${c.color6}
      color7  ${c.color7}
      color8  ${c.color8}
      color9  ${c.color9}
      color10 ${c.color10}
      color11 ${c.color11}
      color12 ${c.color12}
      color13 ${c.color13}
      color14 ${c.color14}
      color15 ${c.color15}
    '';
  };
}
