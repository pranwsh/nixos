{
  config,
  pkgs,
  ...
}: {
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = ["quiet" "loglevel=3" "audit=0" "udev.log_level=3"];
    consoleLogLevel = 3;
    initrd = {
      compressor = "zstd";
      compressorArgs = ["-19" "-T0"];
      kernelModules = [];
      systemd.enable = true;
    };
    loader = {
      timeout = 3;
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    plymouth.enable = false;
    tmp.useTmpfs = true;
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
