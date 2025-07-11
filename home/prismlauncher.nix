{ config, pkgs, inputs, ... }:

{
  home.packages = [
    inputs.PrismLaucnher-Cracked.packages.${pkgs.system}.default
  ];
}
