{ config, pkgs, ... }:

{
  virtualisation.docker = {
    enable = true;
  };

  users.users.pranesh.extraGroups = [ "docker" ];
}
