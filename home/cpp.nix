{ config, pkgs, lib, walNix, ... }:

{
  home.packages = with pkgs; [
      kitty
      fish
      gcc
      cmake
      ninja
      gdb
      valgrind
      cppcheck
  ];
}


