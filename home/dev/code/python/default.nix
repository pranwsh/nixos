{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    python3
    pipx
    pyright
    ruff
    black
    isort
    jupyter
    ipython
  ];

  home.sessionVariables = {
    JUPYTER_RUNTIME_DIR = "${config.home.homeDirectory}/.local/share/jupyter/runtime";
  };

  home.file."code/python/.keep".text = "";
}
