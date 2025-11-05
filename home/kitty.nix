{ config, pkgs, lib, ... }:

let
  style = import ./style.nix;
in 
{
  home.packages = with pkgs; [
    kitty
  ];

  programs.kitty = {
    enable = true;
    shellIntegration.enableBashIntegration = true;

    settings = {
      enable_audio_bell = "no";
      background_opacity = lib.mkForce "${style.opacity.bg}";
      confirm_os_window_close = "0";
      cursor_trail = "1";
    };

    extraConfig = ''

    foreground            #f8f8f2
    selection_foreground  #f8f8f2
    selection_background  #44475a
    url_color             #8be9fd
    cursor                #f8f8f2
    cursor_text_color     #282a36
    color0                #282a36
    color1                #af85f5
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
