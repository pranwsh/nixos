{ pkgs, ... }:

{
  home.packages = [
    pkgs.wineWow64Packages.full
    pkgs.bottles
  ];

}
