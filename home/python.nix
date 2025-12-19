{ pkgs, ... }:

let
  pythonEnv = pkgs.python3.withPackages (ps: with ps; [
    pynvim
    pip
  ]);
in
{
  home.packages = [
    pythonEnv
  ];
}
