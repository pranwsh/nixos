{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    python3
    (pipx.overridePythonAttrs (oldAttrs: {
      doCheck = false;
    }))
    pyright
    ruff
    black
    isort
  ];
}
