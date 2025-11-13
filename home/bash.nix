{
  programs.bash = {
    enable = true;

    initExtra = ''
      set -o vi

      export PS1='\[\033[0;1;31m\]\n \[\033[0;1;31m\]\[\033[30;41m\]\u\[\033[0;1;31m\] \[\033[0;1;34m\]\[\033[30;44m\]\W\[\033[0;1;34m\]\[\033[0;1;35m\] '

      export EDITOR=nvim
      export VISUAL=nvim
    '';
  };
}
