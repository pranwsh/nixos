{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";

    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    spicetify-nix.url = "github:Gerg-L/spicetify-nix";

    zen-browser.url = "github:0xc000022070/zen-browser-flake";

    PrismLaucnher-Cracked.url = "github:Diegiwg/PrismLauncher-Cracked";

    nix-flatpak.url = "github:gmodena/nix-flatpak";
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
            users.pranesh = import ./home/default.nix;
            sharedModules = [
              inputs.nix-flatpak.homeManagerModules.nix-flatpak
            ];
            extraSpecialArgs = { inherit inputs; };
          };
        }
      ];
    };
  };
}
