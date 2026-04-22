{ pkgs, ... }:

{
  home.packages = with pkgs; [
    nixd
    alejandra
    nil
    statix
    deadnix
    nixfmt-rfc-style
  ];

  home.file."code/nix/.keep".text = "";
}
