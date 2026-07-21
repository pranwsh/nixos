{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    # Python libraries
    (python3.withPackages (
      ps: with ps; [
        ddgs
        beautifulsoup4
        requests
        aiohttp
        lxml
        pyyaml
      ]
    ))

    # Python tools
    (pipx.overridePythonAttrs (oldAttrs: {
      doCheck = false;
    }))
  ];
}
