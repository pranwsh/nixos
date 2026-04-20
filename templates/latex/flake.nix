{
  description = "A basic flake for a LaTeX project";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        tex = pkgs.texlive.combine {
          inherit (pkgs.texlive) scheme-medium latexmk;
        };
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = [
            tex
            pkgs.pandoc
          ];
        };
      }
    );
}
