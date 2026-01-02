{ config, pkgs, inputs, walNix, ... }:
let
  profileName = "ro4rmu9s.Default Profile";
  c = (import "${walNix}/colors.nix").colorscheme;
  zenProfilePath = "${config.home.homeDirectory}/.zen/${profileName}";
in
{
  home.packages = [
    inputs.zen-browser.packages.${pkgs.system}.default
  ];
  
  home.file.".zen/${profileName}/chrome" = {
    source = ./config/chrome;
    recursive = true;
  };
  
  home.file.".zen/${profileName}/user.js" = {
    source = ./config/user.js;
  };
  
  home.file.".zen/${profileName}/chrome/nix-colors.json" = {
    text = builtins.toJSON c;
  };
}
