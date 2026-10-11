{ config, pkgs, ... }:

{
  # Minimal global python — libs go in per-project uv venvs.
  home.packages = with pkgs; [ python3 uv ];
}
