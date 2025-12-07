{ config, pkgs, ... }:

{
  users.users.yourUserName.shell = pkgs.fish;

  programs.fish.enable = true;
}
