{
  inputs,
  ...
}: {
  flake.nixosConfigurations.nixos = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = {inherit inputs;};
    modules = [
      ../hardware-configuration.nix
      ../hosts/nixos.nix
      inputs.home-manager.nixosModules.home-manager
      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          users.pranesh = import ../home/default.nix;
          extraSpecialArgs = {
            inherit inputs;
          };
        };
      }
    ];
  };
}
