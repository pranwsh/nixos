{
  config,
  pkgs,
  ...
}: {
  # Add user to plugdev group for USB device access
  users.users.pranesh.extraGroups = ["plugdev" "dialout"];

  # Install usbutils (gives lsusb)
  environment.systemPackages = with pkgs; [
    usbutils
  ];

  # Optional: Enable udev support for EV3 devices
  services.udev.extraRules = ''
    # LEGO EV3 USB access
    ATTR{idVendor}=="0694", ATTR{idProduct}=="0003", MODE="0666", GROUP="plugdev"
    # Alternative EV3 vendor ID
    ATTR{idVendor}=="0694", MODE="0666", GROUP="plugdev"
  '';

  # Ensure plugdev group exists
  users.groups.plugdev = {};
}
