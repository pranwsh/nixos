{
  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      # vi mode
      fish_vi_key_bindings

      # editor
      set -x EDITOR nvim
      set -x VISUAL nvim

      # prompt (roughly mirrors your Bash PS1)
      function fish_prompt
        # newline + leading space
        printf '\n '

        # red segment with user (\u)
        printf '\033[0;1;31m\033[30;41m%s\033[0;1;31m ' (whoami)

        # blue segment with cwd (\W)
        printf '\033[0;1;34m\033[30;44m%s\033[0;1;34m' (prompt_pwd)

        # trailing magenta color
        printf '\033[0;1;35m '
      end
    '';
  };
}
