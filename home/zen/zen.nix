{ config, pkgs, inputs, ... }:
let
  profileName = "ro4rmu9s.Default Profile";
in
{
  # Install Zen browser package
  home.packages = [
    inputs.zen-browser.packages.${pkgs.system}.default
  ];

  # Configure Zen browser profile with custom chrome and user.js
  home.file.".zen/${profileName}/chrome" = {
    source = ./config/chrome;
    recursive = true;
  };
  
  home.file.".zen/${profileName}/user.js" = {
    source = ./config/user.js;
  };
}
