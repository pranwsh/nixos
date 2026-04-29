{ pkgs, osConfig, ... }:
{
  imports = [
    ./core
    ./desktop
    ./dev
    ./apps
  ];

  home.username = osConfig.my.user.name;
  home.homeDirectory = "/home/${osConfig.my.user.name}";

  home.stateVersion = "24.11";
  programs.home-manager.enable = true;
}
