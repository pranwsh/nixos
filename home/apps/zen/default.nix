{
  config,
  osConfig,
  pkgs,
  inputs,
  ...
}: let
  profileName = osConfig.my.user.zenProfileName;
  theme = config.style;
in {
  home.packages = [
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  home.file.".zen/${profileName}/chrome" = {
    source = ./config/chrome;
    recursive = true;
  };

  home.file.".zen/${profileName}/user.js" = {
    text = let 
      original = builtins.readFile ./config/user.js;
    in pkgs.lib.replaceStrings 
      ["/home/pranesh" "pranesh’s" "praneshk119@gmail.com"] 
      ["${config.home.homeDirectory}" "${osConfig.my.user.fullName}’s" "${osConfig.my.user.email}"] 
      original;
  };

  home.file.".zen/${profileName}/chrome/nix-colors.css" = {
    text = ''
      :root {
        --nix-background: ${theme.rgba.background};
      }
    '';
  };
}
