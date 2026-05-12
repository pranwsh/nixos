{ inputs, pkgs, ... }:
{
  home.packages = [
    inputs.hermes.packages.${pkgs.system}.default
  ];
}
