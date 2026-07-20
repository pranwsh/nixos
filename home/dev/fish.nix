{
  config,
  pkgs,
  ...
}:
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
    '';
    functions.fish_mode_prompt = ''
      echo ""
    '';
    functions.fish_prompt = ''
      set_color magenta
      printf '%s\n' ""
      set_color brmagenta
      echo -n ' ◖'
      set_color 000000 -b brmagenta   # black text on brmagenta background
      echo -n (basename (pwd))
      set_color normal
      set_color brmagenta
      echo -n '◗ '
      set_color normal
    '';
  };
}
