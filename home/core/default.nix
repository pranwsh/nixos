{ ... }: {
  imports = [
    ./style.nix
    ./pywal.nix
    ./scripts/nixify/nixify.nix
    ./bluetui.nix
    ./impala.nix
  ];
}
