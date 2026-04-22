{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    PrismLauncher-Cracked.url = "github:Diegiwg/PrismLauncher-Cracked";
    nix-flatpak.url = "github:gmodena/nix-flatpak";
    nvf.url = "github:notashelf/nvf";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs:
    inputs.flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["x86_64-linux"];
      imports = [
        ./parts
      ];
      flake.templates = {
        rust = {
          path = ./templates/rust;
          description = "A basic flake for a Rust project";
        };
        python = {
          path = ./templates/python;
          description = "A basic flake for a Python project";
        };
        go = {
          path = ./templates/go;
          description = "A basic flake for a Go project";
        };
        latex = {
          path = ./templates/latex;
          description = "A basic flake for a LaTeX project";
        };
      };
    };
}
