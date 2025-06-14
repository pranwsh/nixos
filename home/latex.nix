{ config, pkgs, ... }:

let
  texlive = pkgs.texlive.combine {
    inherit (pkgs.texlive) scheme-full latexmk;
  };
in {
  home.packages = with pkgs; [
    texlive
  ];
}
