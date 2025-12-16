{ config, pkgs, ... }:
{
  boot = {
    kernelParams = [ "quiet" "loglevel=3" ];
    consoleLogLevel = 3;
    loader.timeout = 0;
    initrd.systemd.enable = true;
    plymouth.enable = false;
  };
  
  systemd = {
    settings.Manager = {
      ShowStatus = "no";
      RuntimeWatchdogSec = "20s";
    };
    services = {
      systemd-udev-settle.enable = false;
      NetworkManager-wait-online.enable = false;
    };
  };
  
  services.journald.extraConfig = "Storage=volatile";
}
