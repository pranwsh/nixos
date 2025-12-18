{ config, pkgs, lib, walNix, ... }:

let
  theme = import ./style.nix;
  c = (import "${walNix}/colors.nix").colorscheme;
in {
  programs.wofi = {
    enable = true;

    settings = {
      show = "drun";
      prompt = "";
      no_actions = true;

      width = 420;
      height = 260;
      lines = 6;

      normal_window = true;

      location = "center";
      gtk_dark = true;
      hide_scroll = true;
    };

    style = ''
      * {
        font-size: 14px;
      }

      window {
        background-color: ${theme.rgba.background}; /* rgba(0,0,0,.4) */
        border-radius: 30px;
        padding: 10px;
      }

      #outer-box {
        padding: 8px;
      }

      #input {
        background-color: rgba(0,0,0,0);
        color: ${c.color15};
        border-radius: 10px;
        padding: 6px 10px;
        margin-bottom: 8px;
        border: none;
        outline: none;
        box-shadow: none;
      }

      #entry {
        border-radius: 20px;
        padding: 6px 10px;
      }

      #entry:selected {
        background-color: ${theme.rgba.accent};
        border: none;
        outline: none;
        box-shadow: none;
      }

      #text {
        color: ${c.color15};
      }
    '';
  };
}
