{ pkgs, ... }:

{
  home.packages = with pkgs; [
    nixd
    alejandra
    nil
    statix
    deadnix
    nixfmt
  ];

  home.file."code/nix/.keep".text = "";
}
