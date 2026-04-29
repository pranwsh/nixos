{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    python3
    pipx
    pyright
    ruff
    black
    isort
  ];
}
