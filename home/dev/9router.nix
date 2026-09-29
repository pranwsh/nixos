{ pkgs, inputs, ... }:

let
  router-src = inputs.router-src;
in
{
  systemd.user.services."9router" = {
    Unit.Description = "9Router built from source (master) via Docker";
    Install.WantedBy = [ "default.target" ];
    Service = {
      Environment = [ "DOCKER_HOST=unix:///run/user/1000/docker.sock" ];
      ExecStartPre = [
        "-${pkgs.docker}/bin/docker rm -f 9router"
        "${pkgs.docker}/bin/docker build -t 9router-local ${router-src}"
      ];
      ExecStart = "${pkgs.docker}/bin/docker run --rm --name 9router -p 20128:20128 -e INITIAL_PASSWORD=\"123\" -v %h/.9router:/app/data -e DATA_DIR=/app/data 9router-local";
      ExecStop = "${pkgs.docker}/bin/docker stop 9router";
      Restart = "always";
      RestartSec = "5s";
    };
  };
}
