{ config, pkgs, ... }:

{
  systemd.user.services."9router" = {
    Unit = {
      Description = "9Router AI gateway";
      After = [ "network.target" ];
    };
    Service = {
      Environment = [ "DOCKER_HOST=unix:///run/user/1000/docker.sock" ];
      ExecStartPre = "-${pkgs.docker}/bin/docker rm -f 9router";
      ExecStart = ''
        ${pkgs.docker}/bin/docker run --rm \
          --name 9router \
          -p 20128:20128 \
          -e INITIAL_PASSWORD="123" \
          -v %h/.9router:/app/data \
          -e DATA_DIR=/app/data \
          docker.io/decolua/9router:latest
      '';
      ExecStop = "${pkgs.docker}/bin/docker stop 9router";
      Restart = "on-failure";
      RestartSec = 5;
    };
    Install.WantedBy = [ "default.target" ];
  };
}
