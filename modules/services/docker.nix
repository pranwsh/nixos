{ config, pkgs, ... }:

{
  virtualisation.docker = {
    enable = true;
  };

  users.users."${config.my.user.name}".extraGroups = [ "docker" ];
}
