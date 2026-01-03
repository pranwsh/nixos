{ config, lib, pkgs, ... }:

{
  swapDevices = [{
    device = "/swapfile";
    size = 16384;
  }];

  boot.resumeDevice = "/dev/disk/by-label/nixos";
  
  boot.kernelParams = [
    "resume_offset=YOUR_OFFSET_HERE"
  ];

  systemd.sleep.extraConfig = ''
    HibernateDelaySec=30m
  '';

  security.polkit.enable = true;
}

# After applying this configuration:
# 1. sudo nixos-rebuild switch
# 2. Find swap offset: sudo filefrag -v /swapfile | grep "0:" | awk '{print $4}' | sed 's/\.\.//'
# 3. Update boot.kernelParams with the offset value
# 4. sudo nixos-rebuild switch again
# 5. Test hibernation: systemctl hibernate
