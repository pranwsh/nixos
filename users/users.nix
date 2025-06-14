{ config, lib, pkgs, ... }:

{
  users.users.pranesh = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "input" ];
    packages = with pkgs; [ ];
  };
}
