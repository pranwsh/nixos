{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    PrismLauncher-Cracked = {
      url = "github:Diegiwg/PrismLauncher-Cracked";
      # This one needs its own nixpkgs: it depends on patches that do
      # not apply to the current unstable channel.
      inputs.nixpkgs.url = "github:NixOS/nixpkgs/8110df5ad7abf5d4c0f6fb0f8f978390e77f9685";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    harness = {
      url = "github:pranwsh/harness/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    router-src = {
      url = "github:decolua/9router/master";
      # url = "github:decolua/9router?ref=pull/4842/head";
      flake = false;
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      sops-nix,
      ...
    }@inputs:
    let
      username = "pranesh";
    in
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./hardware-configuration.nix
          ./hosts/nixos.nix
          sops-nix.nixosModules.sops
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "bak";
              users."${username}" = import ./home/default.nix;
              extraSpecialArgs = {
                inherit inputs;
              };
            };
          }
        ];
      };
    };
}
