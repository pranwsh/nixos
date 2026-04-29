{ pkgs, ... }:
{
  home.packages = [
    pkgs.pass-wayland
    pkgs.gnupg
    pkgs.pinentry-tty
  ];
}
