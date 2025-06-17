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
{ config, pkgs, ... }:

let
  profileName = "ro4rmu9s.Default Profile";
in {
  home.file.".zen/profiles/${profileName}/chrome" = {
    source = ./chrome;
    recursive = true;
  };
}


