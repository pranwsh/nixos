{ config, pkgs, ... }:

{
  users.users."${config.my.user.name}".shell = pkgs.fish;

  programs.fish.enable = true;
}
