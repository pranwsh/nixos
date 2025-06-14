
{ config, lib, pkgs, ... }:

{
  # Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  services.blueman.enable = true; # Optional: for GUI management via Blueman
}
