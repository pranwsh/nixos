{ pkgs, ... }:
{
  networking.hostName = "nixos";
  networking.wireless.enable = false;
  networking.useDHCP = false;

  hardware.enableRedistributableFirmware = true;

  # RTL8852BE / rtw89 wedges: ping 8.8.8.8 -> Destination Host Unreachable,
  # only reboot fixes, happens on multiple SSIDs => firmware/TX hang, not AP.
  boot.extraModprobeConfig = ''
    options rtw89_core disable_ps_mode=Y
    options rtw89_pci disable_aspm_l1=Y disable_aspm_l1ss=Y disable_clkreq=Y
  '';

  networking.wireless.iwd = {
    enable = true;
    settings = {
      General = {
        EnableNetworkConfiguration = false;
        # Softer than -72/-76: cuts roam-scan churn on eduroam while still
        # roaming before the link becomes unusable.
        RoamThreshold = "-78";
        RoamThreshold5G = "-82";
        CriticalRoamThreshold = "-85";
        CriticalRoamThreshold5G = "-88";
      };
      Network.EnableIPv6 = true;
      # Uncomment to silence iwd background scanning entirely (fewer
      # roam-scans, but no proactive hand-off on eduroam):
      # Scan.DisablePeriodicScan = true;
      # Scan.DisableRoamingScan = true;
    };
  };

  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="net", KERNEL=="w*", \
      RUN+="${pkgs.iw}/bin/iw dev %k set power_save off"
    ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10ec", ATTR{device}=="0xb852", ATTR{d3cold_allowed}="0"
    ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10ec", ATTR{device}=="0xb85b", ATTR{d3cold_allowed}="0"
  '';

  systemd.services.iwd.serviceConfig = {
    Restart = "on-failure";
    RestartSec = "5s";
  };

  # --- Fix: RTL8852BE (rtw89) loses RX across s2idle resume ------------------
  # On s2idle the rtw89 driver/firmware is NOT re-initialized, so wlan0 stays
  # "up" (iwd even reconnects and DHCPs) but no frames flow until the module is
  # reloaded. Known rtw89_8852be "silent RX stalls" regression. Force a cold
  # (re-)probe of the card on the resume path so the broken resume never runs.
  # resumeCommands runs as root as the post-resume step of sleep-actions.service.
  powerManagement.resumeCommands = ''
    ${pkgs.kmod}/bin/modprobe -r rtw89_8852be 2>/dev/null || true
    ${pkgs.kmod}/bin/modprobe rtw89_8852be 2>/dev/null || true
    # systemctl restart blocks until iwd is back up, so no sleeps are needed.
    ${pkgs.systemd}/bin/systemctl restart iwd.service || true
  '';

  # No-reboot recovery helper: systemctl restart wifi-recover
  systemd.services.wifi-recover = {
    description = "Recover wedged rtw89 without reboot";
    path = with pkgs; [
      kmod
      systemd
      iwd
    ];
    serviceConfig.Type = "oneshot";
    script = ''
      modprobe -r rtw89_8852be || true
      modprobe rtw89_8852be || true
      systemctl restart iwd.service || true
    '';
  };

  systemd.network.enable = true;
  systemd.network.wait-online.enable = false;

  systemd.network.networks."10-ignore-virtual" = {
    matchConfig.Name = "veth* br*";
    linkConfig.RequiredForOnline = "no";
  };

  systemd.network.networks."20-wired" = {
    matchConfig.Name = "en* eth*";
    networkConfig.DHCP = "yes";
    dhcpV4Config.UseDNS = true;
    linkConfig.RequiredForOnline = "no";
  };

  systemd.network.networks."25-wireless" = {
    matchConfig.Name = "w*";
    networkConfig = {
      DHCP = "yes";
      IPv6AcceptRA = true;
      KeepConfiguration = "dynamic";
      IgnoreCarrierLoss = true;
    };
    dhcpV4Config = {
      MaxAttempts = 6;
      ClientIdentifier = "mac";
      SendRelease = false;
      UseDNS = true;
    };
    linkConfig.RequiredForOnline = "no";
  };

  services.resolved = {
    enable = true;
    settings.Resolve = {
      DNSSEC = "allow_downgrade";
      DNSOverTLS = true;
      Cache = "yes";
      DNS = [
        "1.1.1.1"
        "8.8.8.8"
      ];
      DNSStubListener = "yes";
    };
  };

  networking.firewall.enable = true;
  services.irqbalance.enable = false;
}
