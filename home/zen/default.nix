{ config, pkgs, inputs, ... }:
let
  profileName = "ro4rmu9s.Default Profile";
  theme = config.myTheme;
  
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
  
  home.file.".zen/${profileName}/chrome/nix-colors.css" = {
    text = ''
      :root {
        --nix-background: ${theme.rgba.background};
      }
    '';
  };
}
