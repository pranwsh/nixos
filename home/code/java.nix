# home.nix
{ pkgs, ... }: {
  home.packages = with pkgs; [
    jdk
  ];
}
