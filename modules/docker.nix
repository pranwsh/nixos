{ config, pkgs, ... }:

{
  virtualisation.docker = {
    enable = true;
  };

# Optional: Add your user to the "docker" group to run docker without sudo
  users.users.pranesh.extraGroups = [ "docker" ];
}
