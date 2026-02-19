# {
#   config,
#   lib,
#   pkgs,
#   ...
# }: {
#   # 1. Disable the heavy/old stuff
#   networking.networkmanager.enable = false;
#   networking.wireless.enable = false; # This disables wpa_supplicant
#   networking.useDHCP = false; # Disable global DHCP (we will enable per-interface)
#
#   # 2. Enable iwd ONLY for Layer 2 (Connecting to WiFi)
#   networking.wireless.iwd = {
#     enable = true;
#     settings = {
#       General = {
#         # IMPORTANT: Disable iwd's internal network config.
#         # We want systemd-networkd to do the IP stuff.
#         EnableNetworkConfiguration = false;
#       };
#       Network = {
#         EnableIPv6 = true;
#         # iwd doesn't need to manage DNS directly anymore
#       };
#     };
#   };
#
#   # 3. Enable systemd-networkd for Layer 3 (IP & DHCP)
#   systemd.network.enable = true;
#
#   # 4. Configure networkd to pick up the wireless interface
#   # "wlan0" is standard, but "w*" acts as a wildcard for any wifi interface
#   systemd.network.networks."25-wireless" = {
#     matchConfig.Name = "w*";
#     networkConfig = {
#       DHCP = "yes";
#       IgnoreCarrierLoss = "3s"; # Helps prevent flaps while roaming
#     };
#   };
#
#   # 5. DNS Resolution
#   services.resolved = {
#     enable = true;
#     # settings.Resolve.DNSSEC = "allow-downgrade";
#     # settings.Resolve.Domains = ["~."];
#     # settings.Resolve.FallbackDNS = ["1.1.1.1" "8.8.8.8"];
#
#     settings.Resolve = {
#       DNSSEC = "allow-downgrade";
#       Domains = ["~."];
#       FallbackDNS = ["1.1.1.1" "8.8.8.8"];
#     };
#   };
#
#   # 6. Firewall (Your existing config was fine)
#   networking.firewall = {
#     enable = true;
#     allowedTCPPortRanges = [
#       {
#         from = 1714;
#         to = 1764;
#       }
#     ];
#     allowedUDPPortRanges = [
#       {
#         from = 1714;
#         to = 1764;
#       }
#     ];
#   };
# }
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
{
  config,
  lib,
  pkgs,
  ...
}: {
  networking.networkmanager.enable = false;
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
      # Tell iwd to aggressively scan and reconnect
      Station = {
        # Always try to reconnect on disconnect
        AutoConnect = true;
        # Scan for known networks every 60s when disconnected
        InitialPeriodicScanInterval = 10;
        MaximumPeriodicScanInterval = 60;
      };
      # Disable power saving — this is the most common cause of random drops
      Scan = {
        DisablePeriodicScan = false;
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
      Domains = ["~."];
      FallbackDNS = ["1.1.1.1" "8.8.8.8"];
      DNSStubListener = "yes";
    };
  };

  # Symlink resolv.conf to the resolved stub (NixOS sometimes needs this explicit)
  environment.etc."resolv.conf".source = "/run/systemd/resolve/stub-resolv.conf";

  # --- Firewall ---
  networking.firewall = {
    enable = true;
    allowedTCPPortRanges = [
      {
        from = 1714;
        to = 1764;
      }
    ];
    allowedUDPPortRanges = [
      {
        from = 1714;
        to = 1764;
      }
    ];
  };
}
