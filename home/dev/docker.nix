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

  systemd.user.services.docker = {
    Unit = {
      Description = "Docker Application Container Engine (Rootless)";
      After = [ "network-online.target" ];
      Wants = [ "network-online.target" ];
    };
    Service = {
      Environment = "DOCKER_HOST=unix://%t/docker.sock";
      ExecStart = "${pkgs.docker}/bin/dockerd-rootless";
      Restart = "always";
      RestartSec = 10;
      Type = "simple";
      LimitNOFILE = "infinity";
    };
    Install.WantedBy = [ "default.target" ];
  };
}