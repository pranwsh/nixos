{ ... }: {
  imports = [
    ./boot.nix
    ./fish.nix
    ./location.nix
    ./networking.nix
    ./nix.nix
    ./pam.nix
    ./sops.nix
    ./zram.nix
  ];
}
