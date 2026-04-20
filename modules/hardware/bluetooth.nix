
{ config, lib, pkgs, ... }:

{
  # Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  services.blueman.enable = false; # Optional: for GUI management via Blueman
}
