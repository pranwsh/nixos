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
    owner = "root";
    mode = "0400";
  };

  services.hermes-agent = {
    enable = true;

    # ── Container Mode: Disabled for Nix-native execution ──
    # Leveraging Nix for dependency management instead of containers
    container.enable = false;

    # ── Model Settings: NVIDIA NIM + Mistral Medium 3.5 ──
    settings = {
      model = {
        base_url = "https://integrate.api.nvidia.com/v1";
        default = "mistralai/mistral-medium-3.5";
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

    # ── MCP Servers ──
    mcpServers = {
      project_fs = {
        command = "${pkgs.nodejs_22}/bin/npx";
        args = [
          "-y"
          "@modelcontextprotocol/server-filesystem"
          "/home/pranesh/projects"
        ];
        tools.include = [
          "read_file"
          "write_file"
          "list_directory"
          "search_files"
        ];
        tools.resources = false;
        timeout = 60;
      };
      git = {
        command = "${pkgs.python312Packages.uv}/bin/uvx";
        args = [
          "mcp-server-git"
          "--repository"
          "/home/pranesh/projects"
        ];
        tools.include = [
          "git_status"
          "git_diff"
          "git_log"
          "git_commit"
          "git_add"
        ];
      };
      github = {
        command = "${pkgs.nodejs_22}/bin/npx";
        args = [
          "-y"
          "@modelcontextprotocol/server-github"
        ];
        tools.include = [
          "list_issues"
          "create_issue"
          "search_code"
          "get_pull_request"
        ];
        tools.resources = false;
        tools.prompts = false;
      };
      nixos = {
        command = "${pkgs.python312Packages.uv}/bin/uvx";
        args = [ "mcp-nixos" ];
        tools.include = [
          "nix"
          "nix_versions"
        ];
      };
      fetch = {
        command = "${pkgs.python312Packages.uv}/bin/uvx";
        args = [ "mcp-server-fetch" ];
        tools.include = [
          "fetch"
          "search"
        ];
      };
    };

    # ── Plugins ──
    extraPlugins = [ hermes-lcm ];
    settings.plugins.enabled = [ "hermes-lcm" ];
    extraDependencyGroups = [ "hindsight" ];

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
      pkgs.python312
      pkgs.python312Packages.pip
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

    # ── Secrets: Inject NVIDIA_API_KEY from sops-nix ──
    # Create env file at service start by reading the raw secret
    systemd.services.hermes-agent.preStart = ''
      mkdir -p /run/hermes-agent
      echo "NVIDIA_API_KEY=$(cat ${config.sops.secrets.nvidia_key.path})" > /run/hermes-agent/hermes.env
      chmod 600 /run/hermes-agent/hermes.env
    '';
    environmentFiles = [ "/run/hermes-agent/hermes.env" ];

    # ── Service Tuning ──
    addToSystemPackages = true;
    workingDirectory = "/home/pranesh/projects"; # Absolute path, no ~
    restart = "always";
    restartSec = 5;
    extraArgs = [ "--verbose" ];
  };
}
