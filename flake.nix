# {
#   description = "NixOS configuration";
#
#   inputs = {
#     nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
#     home-manager.url = "github:nix-community/home-manager";
#     home-manager.inputs.nixpkgs.follows = "nixpkgs";
#     spicetify-nix.url = "github:Gerg-L/spicetify-nix";
#     zen-browser.url = "github:0xc000022070/zen-browser-flake";
#     stylix = {
#       url = "github:danth/stylix";
#       inputs.nixpkgs.follows = "nixpkgs";
#     };
#   };
#
#   outputs = { self,
#               nixpkgs,
#               home-manager,
#               spicetify-nix,
#               ... 
#             }@inputs:
#     let
#       system = "x86_64-linux";
#       pkgs = nixpkgs.legacyPackages.${system};
#     in {
#       nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
#         inherit system;
#         specialArgs = { inherit inputs; };
#         modules = [
#           ./hardware-configuration.nix
#           ./hosts/nixos.nix
#           home-manager.nixosModules.home-manager
#           {
#             home-manager = {
#               useGlobalPkgs = true;
#               useUserPackages = true;
#               users.pranesh = import ./home/home.nix;
#               extraSpecialArgs = { inherit inputs; };
#             };
#           }
#         ];
#       };
#     };
# }

{
  description = "NixOS configuration";
  
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  
  outputs = { nixpkgs, home-manager, ... }@inputs: {
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
            users.pranesh = import ./home/home.nix;
            extraSpecialArgs = { inherit inputs; };
          };
        }
      ];
    };
  };
}
