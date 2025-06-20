{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    kitty
  ];

  programs.kitty = {
    enable = true;
    shellIntegration.enableBashIntegration = true;

    settings = {
      enable_audio_bell = "no";
      background_opacity = lib.mkForce "0.40";
      confirm_os_window_close = "0";
    };

    extraConfig = ''
    # TokyoNight Theme
    foreground            #c0caf5
    # background            #1a1b26
    selection_foreground  #1a1b26
    selection_background  #c0caf5
    url_color             #9ece6a
    cursor                #c0caf5
    cursor_text_color     #1a1b26

    color0  #15161e
    color1  #f7768e
    color2  #64d991
    color3  #e0af68
    color4  #7aa2f7
    color5  #bb9af7
    color6  #7dcfff
    color7  #a9b1d6
    color8  #414868
    color9  #f7768e
    color10 #64d991
    color11 #e0af68
    color12 #7aa2f7
    color13 #bb9af7
    color14 #7dcfff
    color15 #c0caf5
    '';
  };
}
