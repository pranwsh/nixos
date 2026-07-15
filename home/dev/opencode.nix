{ pkgs, ... }:
{
  home.packages = [
    pkgs.opencode
  ];

  programs.fish.interactiveShellInit = ''
    if test -r /run/secrets/mistral_key
      for line in (cat /run/secrets/mistral_key)
        set -l parts (string split -m 1 "=" $line)
        if test (count $parts) -eq 2
          set -gx $parts[1] $parts[2]
        end
      end
    end
  '';

  home.file.".config/opencode/opencode.json".text = builtins.toJSON {
    "$schema" = "https://opencode.ai/config.json";
    model = "mistral/mistral-large-latest";
  };
}
