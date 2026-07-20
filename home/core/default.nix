{ ... }: {
  imports = [
    ./style.nix
    ./scripts/nixify/nixify.nix
    ./bluetui.nix
    ./impala.nix
  ];
}
