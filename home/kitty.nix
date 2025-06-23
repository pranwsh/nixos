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

    foreground            #ff8a6a
    selection_foreground  #c1246b
    selection_background  #ff8a6a
    url_color             #fd4c55
    cursor                #edf0fc
    cursor_text_color     #e13661
    color0                #ffbbbb
    color1                #fd4c55
    color2                #f13c65
    color3                #e13661
    color4                #d62f68
    color5                #c1246b
    color6                #b11f70
    color7                #a11477
    color8                #921981
    color9                #862089
    color10               #792892
    color11               #6d309b
    color12               #6138a4
    color13               #5630aa
    color14               #4c35b0
    color15               #f13c65
    '';
  };
}
