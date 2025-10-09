{ config, pkgs, ... }:
{
  boot = {
    kernelParams = [
      "quiet"
      "loglevel=0"
      "udev.log_priority=3"
      "rd.systemd.show_status=false"
      "rd.udev.log_priority=3"
    ];
    consoleLogLevel = 0;
    initrd.verbose = false;
    plymouth.enable = false;
  };

  systemd.extraConfig = ''
    DefaultStandardOutput=null
    DefaultStandardError=null
  '';
  
  systemd.user.extraConfig = ''
    DefaultStandardOutput=null
    DefaultStandardError=null
  '';

  services.journald.extraConfig = ''
    Storage=none
    ForwardToConsole=no
    ForwardToWall=no
  '';
}
