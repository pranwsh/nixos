{ config, pkgs, ... }:

{
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  programs.fish = {
    enable = true;

    shellInit = ''
      set -gx XCURSOR_THEME "Bibata-Modern-Classic"
      set -gx XCURSOR_SIZE "18"
    '';

    interactiveShellInit = ''
      set -g fish_greeting ""
      fish_vi_key_bindings
      set -gx EDITOR nvim
      set -gx VISUAL nvim
    '';


functions.fish_mode_prompt = ''
  echo ""
'';

functions.fish_prompt = ''

set -l mode_char
switch $fish_bind_mode
case default
set mode_char "N"
case insert
set mode_char "I"
case replace_one
set mode_char "R"
case visual
set mode_char "V"
end


set_color blue
printf '%s\n' ""
printf " "
set_color -b blue brwhite
printf "$mode_char"
set_color normal
set_color blue
printf ''
set_color normal
      set_color blue
      printf ' '

      set_color -b blue brwhite
      printf '%s' (prompt_pwd)

      set_color normal
      set_color blue
      printf ' '

      set_color normal
      printf '♥ \n'
      '';

  };
}


