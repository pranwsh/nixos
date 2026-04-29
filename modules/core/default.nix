{ ... }: {
  imports = [
    ./boot.nix
    ./fish.nix
    ./location.nix
    ./networking.nix
    ./nix.nix
    ./packages.nix
    ./pam.nix
    ./zram.nix
  ];
}
