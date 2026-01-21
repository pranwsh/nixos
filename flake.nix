{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Import home flake using path: instead of git+file:
    home.url = "path:./home";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    home,
    ...
  } @ inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {inherit inputs;};

      modules = [
        ./hardware-configuration.nix
        ./hosts/nixos.nix

        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;

            # Pass through the home flake's inputs
            extraSpecialArgs = {
              inherit (home) inputs;
            };

            users.pranesh = import ./home/default.nix;

            # Import shared modules from home flake
            sharedModules = [
              home.inputs.nix-flatpak.homeManagerModules.nix-flatpak
            ];
          };
        }
      ];
    };
  };
}
