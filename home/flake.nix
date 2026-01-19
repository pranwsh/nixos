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

  outputs = { nixpkgs, home-manager, ... }@inputs: {
    homeConfigurations.pranesh = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      
      extraSpecialArgs = { inherit inputs; };
      
      modules = [
        ./default.nix
        inputs.nix-flatpak.homeManagerModules.nix-flatpak
      ];
    };
  };
}
