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
}