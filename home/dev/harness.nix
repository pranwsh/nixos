{ inputs, ... }: {
  imports = [
    inputs.harness.homeManagerModules.default
  ];

  programs.harness = {
    enable = true;
    llmApiKeyFile = "/run/secrets/ninerouter_key";

    settings = {
      llm = {
        base_url = "http://localhost:20128/v1";
        model = "oc/muse-spark-1.3-contributor-free";
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
        command = "nix";
        args = [
          "shell"
          "nixpkgs#nodejs_22"
          "--command"
          "npx"
          "-y"
          "mcp-searxng"
        ];
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
