{ config, pkgs, ... }:
{
  programs.fish = {
    functions = {
      zathura = "command setsid zathura $argv >/dev/null 2>&1 &";
    };
  };
}
