{ ... }: {
  imports = [
    ./boot.nix
    ./fish.nix
    ./networking.nix
    ./packages.nix
    ./pam.nix
    ./zram.nix
  ];
}
