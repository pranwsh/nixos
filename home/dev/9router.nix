{ pkgs, ... }:

{
  programs.fish.functions."9router" = {
    description = "Start 9Router AI gateway (foreground, Ctrl-C to stop). Stop the 9router user service first: systemctl --user stop 9router";
    body = ''
      ${pkgs.docker}/bin/docker rm -f 9router ^/dev/null; or true
      ${pkgs.docker}/bin/docker run --rm \
        --name 9router \
        -p 20128:20128 \
        -e INITIAL_PASSWORD="123" \
        -v $HOME/.9router:/app/data \
        -e DATA_DIR=/app/data \
        docker.io/decolua/9router:latest
    '';
  };

  # 9router as a user service. Starts on login (no linger), restarts
  # itself if it exits or if dockerd restarts (Requires, not BindsTo).
  systemd.user.services."9router" = {
    Unit = {
      Description = "9Router AI gateway";
      After = [ "docker.service" ];
      Requires = [ "docker.service" ];
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
    Service = {
      Environment = "DOCKER_HOST=unix://%t/docker.sock";
      ExecStartPre = [
        "-${pkgs.docker}/bin/docker rm -f 9router"
        "-${pkgs.docker}/bin/docker pull docker.io/decolua/9router:latest"
      ];
      ExecStart = "${pkgs.docker}/bin/docker run --rm --name 9router -p 20128:20128 -e INITIAL_PASSWORD=\"123\" -v %h/.9router:/app/data -e DATA_DIR=/app/data docker.io/decolua/9router:latest";
      ExecStop = "${pkgs.docker}/bin/docker stop 9router";
      Restart = "always";
      RestartSec = "5s";
    };
  };
}
