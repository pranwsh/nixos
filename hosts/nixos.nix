{ ... }: {
  imports = [
    ../modules
    ../users/users.nix
  ];

  system.stateVersion = "24.11";
}
