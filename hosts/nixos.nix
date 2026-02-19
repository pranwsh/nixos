{
  config,
  pkgs,
  ...
}: {
  nixpkgs.config.allowUnfree = true;
  programs.hyprland.enable = true;

  imports = [
    ../modules/networking.nix
    ../modules/gpu.nix
    ../modules/sound.nix
    ../modules/pam.nix
    ../modules/packages.nix
    ../modules/bluetooth.nix
    ../modules/tlp.nix
    ../modules/flatpak.nix
    # ../modules/docker.nix
    ../modules/boot.nix
    ../modules/kvm.nix
    ../modules/fish.nix
    ../users/users.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos";
  time.timeZone = "America/Los_Angeles";

  nix.settings.experimental-features = ["nix-command" "flakes"];
  system.stateVersion = "24.11";
}
