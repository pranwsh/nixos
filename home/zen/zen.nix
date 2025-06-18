# { pkgs, ... }:
# let
#   zenBrowserSrc = pkgs.fetchFromGitHub {
#     owner = "0xc000022070";
#     repo = "zen-browser-flake";
#     rev = "main";
#     sha256 = "EgYaWbzbtYFLZH1/Eni1ZdLgTwYhe8g9m10UPdBMCmY=";
#   };
#
#   # Use callPackage to get the package set, then select the default package
#   zenBrowserPkgs = pkgs.callPackage zenBrowserSrc { };
#   zenBrowser = zenBrowserPkgs.default;
# in
# {
#   home.packages = [ zenBrowser ];
# }
#
#
# { config, pkgs, ... }:
# let
#   profileName = "ro4rmu9s.Default Profile";
# in {
#   home.file.".zen/${profileName}/chrome" = {
#     source = ./config/chrome;
#     recursive = true;
#   };
#   home.file.".zen/${profileName}/user.js" = {
#     source = ./config/user.js;
#   };
# }
#
{ config, pkgs, inputs, ... }:
let
  profileName = "ro4rmu9s.Default Profile";
in {
  # Install Zen browser package
  home.packages = with pkgs; [
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
