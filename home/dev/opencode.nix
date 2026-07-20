{ pkgs, ... }:
let
  deepResearchSkills = pkgs.fetchFromGitHub {
    owner = "Weizhena";
    repo = "deep-research-skills";
    rev = "e5479f857f484cde13fe69d2f3ce8de7af193bc7";
    hash = "sha256-5R4HgbTPtEds4CMuN8kzlHpPcph9m0/taRrfN0uQnak="; # nix will tell you the real one on first build
  };
in
{
  programs.opencode = {
    enable = true;
    package = pkgs.opencode;

    settings = {
      model = "mistral/mistral-large-latest";
    };

    tui = {
      theme = "system";
    };

    skills = {
      research = "${deepResearchSkills}/skills/research-en";
    };

    agents = {
      web-search = "${deepResearchSkills}/agents/web-search-opencode.md";
    };

    extraPackages = [
      (pkgs.python3.withPackages (ps: [ ps.pyyaml ]))
    ];
  };

  xdg.configFile."opencode/agents/web-search-modules" = {
    source = "${deepResearchSkills}/agents/web-search-modules";
    recursive = true;
  };

  home.sessionVariables = {
    OPENCODE_ENABLE_EXA = "1";
  };

  programs.fish.interactiveShellInit = ''
    if test -r /run/secrets/mistral_key
      set -gx MISTRAL_API_KEY (string trim < /run/secrets/mistral_key)
    end
  '';
}
