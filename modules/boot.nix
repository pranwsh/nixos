{ config, pkgs, ... }:
{
  boot = {
    # Kernel parameters for silence
    kernelParams = [
      "quiet"
      "loglevel=0"
      "udev.log_priority=0"
      "rd.systemd.show_status=false"
      "rd.udev.log_priority=0"
      "vt.global_cursor_default=0"  # Hide cursor
      "mitigations=off"  # Speed boost (disable if security is critical)
    ];
    
    consoleLogLevel = 0;
    
    # Initrd optimizations
    initrd = {
      verbose = false;
      systemd.enable = true;  # Faster than scripts
      compressor = "zstd";  # Faster decompression
      compressorArgs = [ "-19" "-T0" ];
    };
    
    # Disable Plymouth
    plymouth.enable = false;
    
    # Faster bootloader timeout
    loader = {
      timeout = 0;  # Skip bootloader menu
    };
    
    # Kernel optimization
    kernelPackages = pkgs.linuxPackages_latest;  # Latest kernel often faster
  };
  
  # Systemd optimizations
  systemd = {
    # Silence output (use settings.Manager instead of extraConfig)
    settings.Manager = {
      DefaultStandardOutput = "null";
      DefaultStandardError = "null";
      ShowStatus = "no";
      LogLevel = "err";
    };
    
    # Optimize service startup
    services = {
      # Disable unnecessary wait services
      systemd-udev-settle.enable = false;
      NetworkManager-wait-online.enable = false;
    };
    
    # User session silence
    user.extraConfig = ''
      DefaultStandardOutput=null
      DefaultStandardError=null
    '';
  };
  
  # Disable journald completely (faster)
  services.journald = {
    extraConfig = ''
      Storage=none
      ForwardToConsole=no
      ForwardToWall=no
      ForwardToSyslog=no
    '';
    rateLimitBurst = 0;
  };
  
  # Additional speed optimizations
  powerManagement.cpuFreqGovernor = "performance";  # Max CPU at boot
  
  # Reduce boot delay
  systemd.watchdog.runtimeTime = "20s";  # Default is 10min
  
  # Disable getty if not needed
  systemd.services."getty@tty1".enable = false;
  systemd.services."serial-getty@ttyS0".enable = false;
}
