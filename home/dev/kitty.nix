{
  config,
  pkgs,
  lib,
  ...
}: let
  theme = config.style;
in {
  home.packages = with pkgs; [
    kitty
  ];

  programs.kitty = {
    enable = true;

    settings = {
      enable_audio_bell = "no";
      background_opacity = lib.mkForce (toString theme.opacity);
      confirm_os_window_close = "0";
      cursor_trail = "1";
    };

    extraConfig = ''
      foreground ${theme.foreground}
      background ${theme.background}
      cursor     ${theme.colors.color15}

      selection_foreground ${theme.foreground}
      selection_background ${theme.colors.color8}
      url_color ${theme.colors.color6}

      color0  ${theme.colors.color0}
      color1  ${theme.colors.color1}
      color2  ${theme.colors.color2}
      color3  ${theme.colors.color3}
      color4  ${theme.colors.color4}
      color5  ${theme.colors.color5}
      color6  ${theme.colors.color6}
      color7  ${theme.colors.color7}
      color8  ${theme.colors.color8}
      color9  ${theme.colors.color9}
      color10 ${theme.colors.color10}
      color11 ${theme.colors.color11}
      color12 ${theme.colors.color12}
      color13 ${theme.colors.color13}
      color14 ${theme.colors.color14}
      color15 ${theme.colors.color15}
    '';
  };
}
