{ config, ... }:

{
  home.sessionVariables = {
    JUPYTER_RUNTIME_DIR = "${config.home.homeDirectory}/.local/share/jupyter/runtime";
  };
}
