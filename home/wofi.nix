{ config, pkgs, lib, ... }:

let
  style = import ./style.nix;
in 
{
  home.packages = with pkgs; [
    wofi
  ];

}
