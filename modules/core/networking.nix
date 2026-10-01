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

  environment.systemPackages = [ pkgs.iw ];

  networking.wireless.iwd = {
    enable = true;
    settings = {
      General = {
        EnableNetworkConfiguration = false;
        RoamThreshold = "-72";
        RoamThreshold5G = "-76";
      };
      Network.EnableIPv6 = true;
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

  # No-reboot recovery helper: systemctl restart wifi-recover
  systemd.services.wifi-recover = {
    description = "Recover wedged rtw89 without reboot";
    path = with pkgs; [ kmod systemd iwd ];
    serviceConfig.Type = "oneshot";
    script = ''
      iwctl station list || true
      modprobe -r rtw89_8852be || true
      sleep 2
      modprobe rtw89_8852be || true
      sleep 2
      systemctl restart iwd systemd-networkd || true
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
      DNSSEC = "no";
      Cache = "yes";
      DNS = [ "1.1.1.1" "8.8.8.8" ];
      DNSStubListener = "yes";
    };
  };

  networking.firewall.enable = true;
  services.irqbalance.enable = false;
}
