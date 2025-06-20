{ config, pkgs, inputs, ... }:
{
  imports = [ inputs.spicetify-nix.homeManagerModules.default ];
  programs.spicetify =
    let
      spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
    in
      {
      enable = true;

      enabledExtensions = with spicePkgs.extensions; [
        adblock
        hidePodcasts
        shuffle # shuffle+ (special characters are sanitized out of extension names)
      ];
      enabledCustomApps = with spicePkgs.apps; [
      ];
      enabledSnippets = with spicePkgs.snippets; [
      ];

      colorScheme = "custom";
      customColorScheme = {
        text = "ffffff";
        subtext = "b3b3b3";
        sidebar-text = "ffffff";
        main = "00000066";
        sidebar = "00000066";
        player = "00000066";
        card = "00000066";
        shadow = "00000066";
        selected-row = "00000066";
        button = "00000066";
        button-active = "00000066";
        button-disabled = "00000066";
        tab-active = "00000066";
        notification = "00000066";
        notification-error = "00000066";
        misc = "00000066";
      };
    };
}

