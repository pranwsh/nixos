{
  pkgs,
  inputs,
  ...
}:
{
  home.packages = [
    (inputs.PrismLauncher-Cracked.packages.${pkgs.stdenv.hostPlatform.system}.default.override {
      jdks = [
        pkgs.jdk25 # Add Java 25 (if available in your nixpkgs)
        pkgs.jdk21 # Keep Java 21
        pkgs.jdk17 # Keep Java 17
        pkgs.jdk8 # Keep Java 8
      ];
    })
  ];
}
