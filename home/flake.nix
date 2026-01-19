{
  description = "Home Manager configuration for pranesh";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    PrismLaucnher-Cracked.url = "github:Diegiwg/PrismLauncher-Cracked";
    nix-flatpak.url = "github:gmodena/nix-flatpak";
  };

  outputs = { nixpkgs, home-manager, ... }@inputs: 
  let
    system = "x86_64-linux";
  in
  {
    homeConfigurations.pranesh = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.${system};
      extraSpecialArgs = { inherit inputs; };
      modules = [
        ./default.nix
        inputs.nix-flatpak.homeManagerModules.nix-flatpak
      ];
    };

    # Export the home module for use in NixOS
    homeModule = import ./default.nix;
    
    # Also export the inputs so main flake can access them if needed
    inherit inputs;
  };
}

