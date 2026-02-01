{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./options.nix
    ./keymaps.nix
    ./statusline.nix
    ./emptylineindicator.nix
  ];
}
