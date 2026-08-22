{
  pkgs,
  ...
}:
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
        # Emit roaming/disconnect events faster
        RoamThreshold = -75;
        RoamThreshold5G = -80;
      };
      Network = {
        EnableIPv6 = true;
      };
      # Disable background periodic/roam scans: they run every minute at idle,
      # keeping the rtw89 card busy and pinning its IRQ thread (irq/85) to one
      # core. With this off the card is quiet until a connect/disconnect happens.
      Scan = {
        DisablePeriodicScan = true;
      };
    };
  };

  # Disable WiFi power management at the kernel level via udev
  # This is the most reliable way to prevent the adapter sleeping mid-connection
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="net", KERNEL=="w*", \
      RUN+="${pkgs.iw}/bin/iw dev $name set power_save off"
  '';

  # Ensure iwd restarts automatically if it crashes or gets wedged
  systemd.services.iwd = {
    serviceConfig = {
      Restart = "on-failure";
      RestartSec = "5s";
    };
  };

  # --- systemd-networkd ---
  systemd.network.enable = true;
  # Disable wait-online because it often hangs during rebuilds even with anyInterface=true
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
      # Don't mark the system as offline just because wifi blinked
      IgnoreCarrierLoss = "10s";
      # Hand DNS off to systemd-resolved
      DNS = "127.0.0.53";
    };
    dhcpV4Config = {
      # Retry DHCP aggressively on failure
      MaxAttempts = 20;
      # Use a consistent client ID so the router reissues the same IP
      ClientIdentifier = "mac";
      # Re-request immediately on carrier restore rather than waiting for lease expiry
      SendRelease = false;
    };
    linkConfig = {
      # Don't let networkd declare the link "failed" — keep trying
      RequiredForOnline = "no";
    };
  };

  # --- systemd-resolved ---
  services.resolved = {
    enable = true;
    # Ensure /etc/resolv.conf points at the resolved stub
    # so DNS doesn't break after a reconnect
    settings.Resolve = {
      DNSSEC = "allow-downgrade";
      Domains = [ "~." ];
      FallbackDNS = [
        "1.1.1.1"
        "8.8.8.8"
      ];
      DNSStubListener = "yes";
    };
  };

  # Symlink resolv.conf to the resolved stub (NixOS sometimes needs this explicit)
  environment.etc."resolv.conf".source = "/run/systemd/resolve/stub-resolv.conf";

  # --- Firewall ---
  networking.firewall = {
    enable = false;
  };

  # Balance IRQs across cores so the wifi card's interrupts
  # (rtw89_pci) don't pile up on a single core.
  services.irqbalance.enable = true;
}
