{
  config,
  pkgs,
  inputs,
  ...
}:
let
  hermes-lcm = pkgs.fetchFromGitHub {
    owner = "stephenschoettler";
    repo = "hermes-lcm";
    rev = "v0.7.0";
    # 🔧 Run this to get the correct hash:
    # nix-prefetch-url --unpack https://github.com/stephenschoettler/hermes-lcm/archive/v0.7.0.tar.gz
    hash = "sha256-0D5htaT/Y7uhYfI0yV1L7tiPjGf4kOJDdTMsb96uvhk=";
  };
in
{
  sops.secrets.nvidia_key = {
    owner = "pranesh";
    mode = "0400";
  };

  sops.secrets.mistral_key = {
    owner = "pranesh";
    mode = "0400";
  };

  services.hermes-agent = {
    enable = false;
    user = "pranesh";

    # ── Container Mode: Disabled for Nix-native execution ──
    # Leveraging Nix for dependency management instead of containers
    container.enable = false;

    # ── Model Settings: NVIDIA NIM + Llama 3.3 70B ──
    settings = {
      model = {
        base_url = "https://integrate.api.nvidia.com/v1";
        default = "meta/llama-3.3-70b-instruct";
        # Recommended params for deterministic coding output
        temperature = 0.1;
        top_p = 0.95;
        max_tokens = 8192;
      };
      toolsets = [ "all" ];
      max_turns = 100;
      terminal.backend = "local";
      terminal.timeout = 180;
      memory.memory_enabled = true;
      memory.user_profile_enabled = true;
      display.compact = false;
      compression.enabled = true;
    };

    # ── Plugins ──
    extraPlugins = [ hermes-lcm ];
    settings.plugins.enabled = [ "hermes-lcm" ];

    # ── Nix-managed Tooling Environment ──
    extraPackages = [
      pkgs.git
      pkgs.ripgrep
      pkgs.fd
      pkgs.just
      pkgs.direnv
      pkgs.gh
      pkgs.ruff
      pkgs.prettier
      pkgs.eslint
      pkgs.shellcheck
      pkgs.typos
      pkgs.cargo
      pkgs.rustup
      pkgs.go
      pkgs.python312Packages.pip
      pkgs.uv
      pkgs.nodejs_22
      pkgs.bun
      pkgs.jq
      pkgs.yq
      pkgs.bat
      pkgs.difftastic
      pkgs.fzf
      pkgs.tmate
      pkgs.httpie
      pkgs.curl
      pkgs.wget
      pkgs.pandoc
      pkgs.mkdocs
      # Removed docker-client/podman since container backend is disabled
    ];

    # ── Service Tuning ──
    addToSystemPackages = true;
    restart = "always";
    restartSec = 5;
    extraArgs = [ ];
  };
}
