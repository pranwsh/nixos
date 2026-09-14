{ pkgs, ... }:

{
  programs.fish.functions."9router" = {
    description = "Start 9Router AI gateway (foreground, Ctrl-C to stop)";
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
}
