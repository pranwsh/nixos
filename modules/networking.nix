{ config, lib, pkgs, ... }:

{
  networking.useNetworkd = true;
  systemd.network.enable = true;
  networking.networkmanager.enable = false;

  networking.wireless.iwd = {
    enable = true;
    settings = {
      General = {
        EnableNetworkConfiguration = true;
      };
      Network = {
        NameResolvingService = "systemd";
      };
    };
  };

  services.resolved = {
    enable = true;
    fallbackDns = [ "1.1.1.1" "8.8.8.8" ];
  };
}
