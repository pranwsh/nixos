{ config, pkgs, ... }:

{
  users.users.pranesh.shell = pkgs.fish;

  programs.fish.enable = true;
}
