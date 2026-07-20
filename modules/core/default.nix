{ ... }: {
  imports = [
    ./boot.nix
    ./location.nix
    ./networking.nix
    ./nix.nix
    ./packages.nix
    ./pam.nix
    ./sops.nix
    ./zram.nix
  ];
}
