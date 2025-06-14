{ config, pkgs, lib, ... }:
{
  xdg.configFile."nvim".source = ./.;
}
