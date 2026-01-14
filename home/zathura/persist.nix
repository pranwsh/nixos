
{ config, pkgs, ... }:

{
  programs.fish = {
    shellAliases = {
      zathura = "setsid zathura $argv >/dev/null 2>&1 &";
    };
  };
}
