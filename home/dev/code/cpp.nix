{pkgs, ...}: {
  home.packages = with pkgs; [
    gcc
    cmake
    ninja
    gdb
    valgrind
    cppcheck
    gnumake
  ];
}
