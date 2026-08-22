{ ... }: {
  imports = [
    ./style.nix
    ./fonts.nix
    ./scripts/nixify/nixify.nix
    ./bluetui.nix
    ./impala.nix
  ];
}
