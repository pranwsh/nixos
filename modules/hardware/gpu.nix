{
  config,
  pkgs,
  ...
}: {
  # 1. Load AMD Kernel Drivers (Must be done at system level)
  boot.initrd.kernelModules = ["amdgpu"];
  services.xserver.videoDrivers = ["amdgpu"];

  # 2. Enable Graphics & ROCm (Must be done at system level)
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      rocmPackages.clr
      rocmPackages.clr.icd
    ];
  };
}
