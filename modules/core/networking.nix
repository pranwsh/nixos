{ pkgs, ... }:
{
  networking.hostName = "nixos";
  networking.wireless.enable = false;
  networking.useDHCP = false;

  # --- iwd ---
  networking.wireless.iwd = {
    enable = true;
    settings = {
      General = {
        EnableNetworkConfiguration = false;
        RoamThreshold = -75;
        RoamThreshold5G = -80;
      };
      Network.EnableIPv6 = true;
      Scan.DisablePeriodicScan = true;
    };
  };

  # Disable WiFi power management via udev
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="net", KERNEL=="w*", \
      RUN+="${pkgs.iw}/bin/iw dev $name set power_save off"
  '';

  systemd.services.iwd.serviceConfig = {
    Restart = "on-failure";
    RestartSec = "5s";
  };

  # --- systemd-networkd ---
  systemd.network.enable = true;
  systemd.network.wait-online.enable = false;

  systemd.network.networks."10-ignore-virtual" = {
    matchConfig.Name = "veth* br*";
    linkConfig.RequiredForOnline = "no";
  };

  systemd.network.networks."25-wireless" = {
    matchConfig.Name = "w*";
    networkConfig = {
      DHCP = "yes";
      IPv6AcceptRA = true;
      IgnoreCarrierLoss = "10s";
      DNS = "127.0.0.53";
    };
    dhcpV4Config = {
      MaxAttempts = 20;
      ClientIdentifier = "mac";
      SendRelease = false;
      UseDNS = false;
    };
    ipv6AcceptRAConfig.UseDNS = false;
    linkConfig.RequiredForOnline = "no";
  };

  # --- systemd-resolved ---
  services.resolved = {
    enable = true;
    settings.Resolve = {
      DNSSEC = "allow-downgrade";
      Domains = [ "~." ];
      DNS = [
        "1.1.1.1"
        "8.8.8.8"
      ];
      DNSStubListener = "yes";
    };
  };

  # --- Firewall ---
  networking.firewall.enable = false;

  services.irqbalance.enable = true;
}
