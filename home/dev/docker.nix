{
  pkgs,
  config,
  ...
}:
{
  home.packages = with pkgs; [
    docker-client
    docker-compose
  ];

  home.sessionVariables = {
    DOCKER_HOST = "unix://$XDG_RUNTIME_DIR/docker.sock";
  };

  programs.fish.functions.dockerd = {
    description = "Start rootless Docker daemon (foreground, Ctrl-C to stop)";
    body = ''
      ${pkgs.docker}/bin/dockerd-rootless
    '';
  };

  # Rootless dockerd as a user service. Starts on login (no linger),
  # restarts on failure. Manual `dockerd` fish function above remains
  # as a debug fallback — stop this service before using it.
  systemd.user.services.docker = {
    Unit = {
      Description = "Rootless Docker daemon";
      After = [ "network.target" ];
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
    Service = {
      Environment = "DOCKER_HOST=unix://%t/docker.sock";
      ExecStart = "${pkgs.docker}/bin/dockerd-rootless";
      Restart = "always";
      RestartSec = "5s";
    };
  };
}