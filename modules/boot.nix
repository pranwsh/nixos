
{ config, pkgs, ... }:

{
  boot = {
    kernelParams = [
      "quiet"
      "loglevel=0"
      "udev.log_priority=3"
    ];

    consoleLogLevel = 0;
    initrd.verbose = false;

    plymouth.enable = false;
  };
}
