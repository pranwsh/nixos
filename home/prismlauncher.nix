{
  pkgs,
  inputs,
  ...
}: {
  home.packages = [
    inputs.PrismLaucnher-Cracked.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
