{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  nixpkgs.config.allowUnfree = true;
  programs.hyprland.enable = true;

  imports = [
    ../modules
    ../users/users.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos";
  time.timeZone = "America/Los_Angeles";

  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    auto-optimise-store = true;
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  # Link flake inputs to nix registry
  nix.registry = lib.mapAttrs (_: value: { flake = value; }) inputs;
  nix.nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;

  system.stateVersion = "24.11";
}
