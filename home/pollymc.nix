{ config, pkgs, inputs, ... }:
{
  home.packages = [
    inputs.pollymc.packages.${pkgs.system}.default
  ];
}
