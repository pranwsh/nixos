{
  description = "NixOS configuration for Pranesh";
  
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
  };
  
  outputs = { self,
              nixpkgs,
              home-manager,
              spicetify-nix,
              ... 
            }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [
          ./hardware-configuration.nix
          ./hosts/nixos.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.pranesh = import ./home/home.nix;
              extraSpecialArgs = { inherit inputs; };
            };
          }
        ];
      };
    };
}
