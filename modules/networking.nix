# {
#   config,
#   lib,
#   pkgs,
#   ...
# }: {
#   # networking.useNetworkd = true;
#   # systemd.network.enable = true;
#   networking.networkmanager.enable = false;
#   networking.wireless.enable = false;
#
#   networking.wireless.iwd = {
#     enable = true;
#     settings = {
#       General = {
#         EnableNetworkConfiguration = true;
#       };
#       Network = {
#         NameResolvingService = "systemd";
#       };
#     };
#   };
#
#   services.resolved = {
#     enable = true;
#     settings.Resolve.FallbackDns = ["1.1.1.1" "8.8.8.8"];
#   };
#
#   networking.firewall = {
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
{
  config,
  lib,
  pkgs,
  ...
}: {
  # Disable everything except iwd
  networking.networkmanager.enable = false;
  networking.wireless.enable = false;
  networking.useDHCP = false;
  networking.dhcpcd.enable = false;

  # Let iwd handle everything
  networking.wireless.iwd = {
    enable = true;
    settings = {
      General = {
        EnableNetworkConfiguration = true;
      };
      Network = {
        EnableIPv6 = true;
        NameResolvingService = "systemd";
      };
    };
  };

  # DNS resolution
  services.resolved = {
    enable = true;
    fallbackDns = ["1.1.1.1" "8.8.8.8"];
  };

  # Firewall
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
