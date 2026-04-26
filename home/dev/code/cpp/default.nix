{ pkgs, ... }:

{
  home.packages = with pkgs; [
    gcc
    gdb
    cmake
    gnumake
    clang-tools # for clangd, clang-format
    cppcheck
  ];

  home.file."code/cpp/.keep".text = "";
}
