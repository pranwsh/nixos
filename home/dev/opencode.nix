{ pkgs, ... }:
{
  home.packages = [
    pkgs.opencode
  ];
  programs.fish.interactiveShellInit = ''
    if test -r /run/secrets/mistral_key
      set -gx MISTRAL_API_KEY (string trim < /run/secrets/mistral_key)
    end
  '';
  home.file.".config/opencode/opencode.json".text = builtins.toJSON {
    "$schema" = "https://opencode.ai/config.json";
    model = "mistral/mistral-large-latest";
    theme = "system";
  };
}
