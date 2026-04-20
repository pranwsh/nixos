{ pkgs, osConfig, ... }: {
  imports = [
    ./core
    ./desktop
    ./dev
    ./apps
  ];

  home.username = osConfig.my.user.name;
  home.homeDirectory = "/home/${osConfig.my.user.name}";

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
