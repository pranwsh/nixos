{ pkgs, ... }: {
  imports = [
    ./core
    ./desktop
    ./dev
    ./apps
  ];

  home.username = "pranesh";
  home.homeDirectory = "/home/pranesh";

  home.packages = [
    pkgs.wineWow64Packages.stable
    pkgs.discord
    pkgs.libreoffice
    pkgs.qemu
    pkgs.chromium
    pkgs.bluetui
    pkgs.impala
    pkgs.yazi
    pkgs.gemini-cli
  ];

  home.stateVersion = "24.11";
  programs.home-manager.enable = true;
}
