{
  config,
  lib,
  pkgs,
  ...
}:
{
  # 1. Load AMD Kernel Drivers (Must be done at system level)
  boot.kernelModules = [ "amdgpu" ];
  services.xserver.videoDrivers = [ "amdgpu" ];

  # 2. Enable Graphics & VA-API hardware decoding (Must be done at system level)
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      mesa
      libva
      libva-vdpau-driver
    ];
  };

  environment.systemPackages = [ pkgs.libva-utils ];
}
