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

    # foreground            #FF6F61
    # selection_foreground  #D8BFD8
    # selection_background  #FFA6C9
    # url_color             #A98ABF
    # cursor                #FFCCE7
    # cursor_text_color     #CBAACB
    # color0                #FF99CC
    # color1                #BAA0D0
    # color2                #F8D8A8
    # color3                #DDA0DD
    # color4                #FFE4B5
    # color5                #E49EC2
    # color6                #FFDAB9
    # color7                #F8BBD0
    # color8                #FFCBA4
    # color9                #FFD1DC
    # color10               #E0A3C2
    # color11               #FFCCAA
    # color12               #FF8C94
    # color13               #D895C2
    # color14               #FFF0D9
    # color15               #FFB3C1
    #

    foreground            #F76DA6
    selection_foreground  #FFC2D6
    selection_background  #FF99BB
    url_color             #FF99AD
    cursor                #EA70A8
    cursor_text_color     #D95CA4
    color0                #E6B0E6
    color1                #FFB8DE
    color2                #A266CC
    color3                #B07ADD
    color4                #FFF1C2
    color5                #FFD488
    color6                #E090E0
    color7                #FFB86C
    color8                #FFC285
    color9                #FFCD8F
    color10               #FF78B4
    color11               #FF66AA
    color12               #FFB273
    color13               #D291D2
    color14               #FF5E6F
    color15               #FF4C4C
    '';
  };
}
