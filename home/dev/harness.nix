# Agent harness TUI (`harness`), replicating the previous hand-maintained
# `~/.config/harness/config.toml`.
#
# `programs.harness` (from the harness flake) generates
# `$XDG_CONFIG_HOME/harness/config.toml` from `settings` and installs a
# wrapper passing `--config <managed path>`, since the binary otherwise
# only reads `./config.toml` from the cwd.
{inputs, ...}: {
  imports = [
    inputs.harness.homeManagerModules.default
  ];

  programs.harness = {
    enable = true;
    settings = {
      llm = {
        # Local 9router proxy (see ./9router.nix).
        base_url = "http://localhost:20128/v1";
        model = "oc/muse-spark-1.3-contributor-free";
        # Same value as sops `ninerouter_key`; kept here so the generated
        # file matches the previous hand-maintained config.toml.
        # NOTE: lands in the Nix store (world-readable). Follow-up:
        # move this into a sops template so the secret stays out of
        # the store (and out of this git repo).
        api_key = "sk-cdad3cb1abd9fc0b-ust4ab-f4a4aff6";
      };
      agent.max_iterations = 128;
      session.enabled = true;
      shell = {
        default_timeout_ms = 30000;
        max_timeout_ms = 120000;
        max_output_bytes = 65536;
        max_capture_bytes = 1048576;
        max_jobs = 32;
        max_job_time_ms = 600000;
        max_job_output_bytes = 262144;
      };
      mcp.servers.searxng = {
        # `nix shell` provides node (see modules/core/nix.nix flakes);
        # plain `npx` is not on PATH.
        command = "nix";
        args = ["shell" "nixpkgs#nodejs_22" "--command" "npx" "-y" "mcp-searxng"];
        env = {
          SEARXNG_URL = "http://127.0.0.1:8888";
          SEARXNG_FANOUT = "false";
          SEARXNG_TIMEOUT_MS = "10000";
          SEARXNG_MAX_RESULTS = "5";
          SEARXNG_HTML_FALLBACK = "false";
          NO_PROXY = "127.0.0.1,localhost";
        };
      };
    };
  };
}
