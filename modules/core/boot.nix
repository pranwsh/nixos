{
  config,
  pkgs,
  ...
}: {
  boot = {
    kernelPackages = pkgs.linuxPackages_zen;
    kernelParams = ["quiet" "loglevel=3" "audit=0" "udev.log_level=3" "nowatchdog"];
    consoleLogLevel = 3;
    kernel.sysctl = {
      "net.core.default_qdisc" = "fq";
      "net.ipv4.tcp_congestion_control" = "bbr";
      "net.ipv4.tcp_fastopen" = 3;
      "vm.swappiness" = 10;
      "fs.inotify.max_user_watches" = 524288;
    };
    initrd = {
      compressor = "zstd";
      compressorArgs = ["-19" "-T0"];
      kernelModules = [];
      systemd.enable = true;
    };
    loader = {
      timeout = 3;
      systemd-boot.enable = true;
      systemd-boot.configurationLimit = 10;
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
  services.dbus.implementation = "broker";
  systemd.oomd.enable = true;
}
