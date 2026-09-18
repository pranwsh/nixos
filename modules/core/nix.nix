{ config, lib, inputs, ... }: {
  nixpkgs.config.allowUnfree = true;

  # sops-nix still calls buildGo125Module, but current nixpkgs removed it
  # (Go 1.25 EOL). Alias it to the 1.26 builder.
  nixpkgs.overlays = [
    (final: prev: {
      buildGo125Module = prev.buildGo126Module;
    })
  ];

  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    # build dirs on disk (not the 7.5G /tmp tmpfs); must not be world-writable
    build-dir = "/nix/var/nix/builds";
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
}
