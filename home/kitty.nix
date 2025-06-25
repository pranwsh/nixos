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

    # foreground            #ff8a6a
    # selection_foreground  #c1246b
    # selection_background  #ff8a6a
    # url_color             #fd4c55
    # cursor                #edf0fc
    # cursor_text_color     #e13661
    # color0                #ffbbbb
    # color1                #fd4c55
    # color2                #f13c65
    # color3                #e13661
    # color4                #d62f68
    # color5                #c1246b
    # color6                #b11f70
    # color7                #a11477
    # color8                #921981
    # color9                #862089
    # color10               #792892
    # color11               #6d309b
    # color12               #6138a4
    # color13               #5630aa
    # color14               #4c35b0
    # color15               #f13c65
    #
    foreground            #f8f8f2
    selection_foreground  #f8f8f2
    selection_background  #44475a
    url_color             #8be9fd
    cursor                #f8f8f2
    cursor_text_color     #282a36
    color0                #282a36
    color1                #ff5555
    color2                #50fa7b
    color3                #f1fa8c
    color4                #bd93f9
    color5                #ff79c6
    color6                #8be9fd
    color7                #f8f8f2
    color8                #6272a4
    color9                #ff5555
    color10               #50fa7b
    color11               #f1fa8c
    color12               #bd93f9
    color13               #ff79c6
    color14               #8be9fd
    color15               #ff79c6
    '';
  };
}
