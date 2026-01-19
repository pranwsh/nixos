{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    # Reference home as a git+file flake
    home.url = "git+file:./home";
  };

  outputs = { nixpkgs, home-manager, home, ... }@inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        ./hardware-configuration.nix
        ./hosts/nixos.nix
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.pranesh = home.homeModule;
            sharedModules = [
              home.inputs.nix-flatpak.homeManagerModules.nix-flatpak
            ];
            extraSpecialArgs = { 
              inputs = home.inputs;
            };
          };
        }
      ];
    };
  };
}
