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
#
# let
#   profileName = "ro4rmu9s.Default Profile";
# in {
#   home.file.".zen/profiles/${profileName}/chrome" = {
#     source = ./chrome;
#     recursive = true;
#   };
# }
#
{ config, pkgs, lib, ... }:
let
  # Read the profiles.ini file
  # profilesIni = builtins.readFile "${config.home.homeDirectory}/.zen/profiles.ini";

  profilesIni = builtins.readFile "~/.zen/profiles.ini";
  
  # Parse the INI file to extract the default profile path
  # This looks for the Default=1 profile and extracts its Path
  parseDefaultProfile = content:
    let
      lines = lib.splitString "\n" content;
      # Find sections and their properties
      sections = lib.foldl (acc: line:
        let
          trimmed = lib.trim line;
          isSection = lib.hasPrefix "[" trimmed && lib.hasSuffix "]" trimmed;
          sectionName = if isSection then lib.substring 1 (lib.stringLength trimmed - 2) trimmed else null;
          isKeyValue = lib.contains "=" trimmed && !isSection;
          keyValue = if isKeyValue then 
            let parts = lib.splitString "=" trimmed;
            in { key = lib.trim (lib.head parts); value = lib.trim (lib.concatStringsSep "=" (lib.tail parts)); }
            else null;
        in
          if isSection then
            acc // { currentSection = sectionName; "${sectionName}" = {}; }
          else if isKeyValue && acc.currentSection != null then
            acc // { "${acc.currentSection}" = acc.${acc.currentSection} // { "${keyValue.key}" = keyValue.value; }; }
          else
            acc
      ) { currentSection = null; } lines;
      
      # Find the profile with Default=1
      defaultProfile = lib.findFirst 
        (name: 
          lib.hasAttr name sections && 
          lib.hasAttr "Default" sections.${name} && 
          sections.${name}.Default == "1"
        ) 
        null 
        (lib.attrNames sections);
        
      profilePath = if defaultProfile != null && lib.hasAttr "Path" sections.${defaultProfile}
        then sections.${defaultProfile}.Path
        else throw "Could not find default profile path in profiles.ini";
    in profilePath;
  
  # Get the dynamic profile name
  profileName = parseDefaultProfile profilesIni;
  
in {
  home.file.".zen/profiles/${profileName}/chrome" = {
    source = ./chrome;
    recursive = true;
  };
}
