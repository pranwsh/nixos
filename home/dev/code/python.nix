{ pkgs, config, ... }:

let
  pythonEnv = pkgs.python3.withPackages (
    ps: with ps; [
      pynvim
      pip
    ]
  );
in
{
  home.packages = [
    pythonEnv
  ];
  home.sessionVariables = {
    JUPYTER_RUNTIME_DIR = "${config.home.homeDirectory}/.local/share/jupyter/runtime";
  };
}
