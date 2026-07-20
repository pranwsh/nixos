{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    (python3.withPackages (
      ps: with ps; [
        ddgs
        beautifulsoup4
        requests
        aiohttp
        lxml
      ]
    ))
    (pipx.overridePythonAttrs (oldAttrs: {
      doCheck = false;
    }))
    pyright
    ruff
    black
    isort
  ];
}
