{
  config,
  pkgs,
  ...
}: {
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
      set_color cyan
      printf '%s\n' ""
      set_color brcyan
      echo -n ' ◖'
      set_color black -b brcyan   # black text on brcyan background
      echo -n (basename (pwd))
      set_color normal
      set_color brcyan
      echo -n '◗ '
      set_color normal
    '';
  };
}
