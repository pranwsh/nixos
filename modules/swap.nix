{ config, lib, pkgs, ... }:

{
  swapDevices = [{
    device = "/swapfile";
    size = 16384;
  }];

  boot.resumeDevice = "/dev/disk/by-label/nixos";
  
  boot.kernelParams = [
    "resume_offset=34551808"
  ];

  systemd.sleep.extraConfig = ''
    HibernateDelaySec=30m
  '';

  security.polkit.enable = true;
}
