{ pkgs, osConfig, ... }:
{
  imports = [
    ./core
    ./desktop
    ./dev
    ./apps
  ];

  home.username = pkgs.lib.mkForce osConfig.my.user.name;
  home.homeDirectory = pkgs.lib.mkForce "/home/${osConfig.my.user.name}";

  home.stateVersion = "24.11";
  programs.home-manager.enable = true;
}
