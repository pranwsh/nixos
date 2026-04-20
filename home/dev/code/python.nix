{ pkgs, ... }:

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
    JUPYTER_RUNTIME_DIR = "/home/pranesh/.local/share/jupyter/runtime";
  };
}
