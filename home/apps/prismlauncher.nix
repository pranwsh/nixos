{
  pkgs,
  inputs,
  ...
}:
{
  home.packages = [
    (inputs.PrismLauncher-Cracked.packages.${pkgs.stdenv.hostPlatform.system}.default.override {
      jdks = [
        pkgs.jdk25
      ];
    })
  ];
}
