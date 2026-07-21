{ pkgs, lib, ... }:
let
  sources = {
    deepResearch = pkgs.fetchFromGitHub {
      owner = "Weizhena";
      repo = "deep-research-skills";
      rev = "e5479f857f484cde13fe69d2f3ce8de7af193bc7";
      hash = "sha256-5R4HgbTPtEds4CMuN8kzlHpPcph9m0/taRrfN0uQnak=";
    };
  };

  skills = {
    research = "${sources.deepResearch}/skills/research-en";
  };

  agents = {
    web-search = "${sources.deepResearch}/agents/web-search-opencode.md";
  };

  agentSupportDirs = {
    "web-search-modules" = "${sources.deepResearch}/agents/web-search-modules";
  };

in
{
  programs.opencode = {
    enable = true;
    package = pkgs.opencode;

    settings = {
      model = "mistral/mistral-large-latest";

      # Force web-search to stay a hidden subagent, regardless of
      # what its own frontmatter says.
      agent = {
        web-search = {
          mode = "subagent";
          hidden = true;
        };
      };
    };

    tui = {
      theme = "system";
    };

    inherit skills agents;

    extraPackages = [
      (pkgs.python3.withPackages (ps: [ ps.pyyaml ]))
    ];
  };

  xdg.configFile = lib.mapAttrs' (
    name: src:
    lib.nameValuePair "opencode/agents/${name}" {
      source = src;
      recursive = true;
    }
  ) agentSupportDirs;

  home.sessionVariables = {
    OPENCODE_ENABLE_EXA = "1";
  };

  programs.fish.interactiveShellInit = ''
    if test -r /run/secrets/mistral_key
      set -gx MISTRAL_API_KEY (string trim < /run/secrets/mistral_key)
    end
  '';
}
