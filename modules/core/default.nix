{ ... }: {
  imports = [
    ./boot.nix
    ./fish.nix
    ./location.nix
    ./networking.nix
    ./nix.nix
    ./nix-ld.nix
    ./pam.nix
    ./sops.nix
    ./zram.nix
  ];
}
