{ config, pkgs, ... }:
{
  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "user-with-access-to-virtualbox" ];
  
  # Add VirtualBox to system packages
  environment.systemPackages = with pkgs; [
    virtualbox
  ];
}
