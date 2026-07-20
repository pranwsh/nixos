{
  config,
  lib,
  pkgs,
  ...
}:
{
  users.users."${config.my.user.name}" = {
    isNormalUser = lib.mkForce true;
    isSystemUser = lib.mkForce false;
    home = lib.mkForce "/home/${config.my.user.name}";
    shell = pkgs.fish;
    extraGroups = [
      "wheel"
      "video"
      "input"
      "docker"
    ];
  };
}
