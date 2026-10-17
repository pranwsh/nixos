{ ... }:
{
  networking.hostName = "nixos";
  networking.useDHCP = false;

  hardware.enableRedistributableFirmware = true;

  networking.wireless.iwd = {
    enable = true;
    settings = {
      General.EnableNetworkConfiguration = false;
      Network.EnableIPv6 = true;
    };
  };

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
