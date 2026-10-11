{ pkgs, ... }:
{
  # User diagnostics / controls that were in environment.systemPackages.
  # Kept in home so system closure stays minimal.
  home.packages = with pkgs; [
    pamixer # audio control (pipewire)
    acpi # battery info (tlp-stat covers most, kept for scripts)
    libva-utils # vainfo — va-api check (drivers stay system-level)
    usbutils # lsusb
    iw # wifi diagnostics (udev rule refs it, no need for systemPackages)
  ];
}
