{
  config,
  pkgs,
  ...
}:
{
  users.users."${config.my.user.name}" = {
    isNormalUser = pkgs.lib.mkForce true;
    isSystemUser = pkgs.lib.mkForce false;
    extraGroups = [
      "wheel"
      "video"
      "input"
    ];
  };
}
