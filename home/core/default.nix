{ ... }: {
  imports = [
    ./style
    ./fonts.nix
    ./scripts/nixify/nixify.nix
    ./bluetui.nix
    ./impala.nix
  ];
}
