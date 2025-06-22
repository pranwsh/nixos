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

    foreground            #FFB273
    selection_foreground  #E090E0
    selection_background  #FFCD8F
    url_color             #FF4C4C
    cursor                #FFC285
    cursor_text_color     #FF5E6F
    color0                #FFB86C
    color1                #A266CC
    color2                #FF78B4
    color3                #B07ADD
    color4                #EA70A8
    color5                #FF99AD
    color6                #FF66AA
    color7                #E6B0E6
    color8                #D291D2
    color9                #FFD488
    color10               #FF99BB
    color11               #F76DA6
    color12               #FFC2D6
    color13               #FF4C4C
    color14               #D95CA4
    color15               #FFF1C2
    '';
  };
}
