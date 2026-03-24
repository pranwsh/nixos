{ pkgs, inputs, ... }:

let
  pkgs' = pkgs.extend inputs.rust-overlay.overlays.default;
in
{
  home.packages = [
    (pkgs'.rust-bin.nightly.latest.default.override {
      extensions = [ "rust-src" "rust-analyzer" ];
    })
  ];
}
