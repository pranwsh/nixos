{
  config,
  pkgs,
  ...
}:
{
  users.users."${config.my.user.name}" = {
    isNormalUser = pkgs.lib.mkForce true;
    isSystemUser = pkgs.lib.mkForce false;
    home = pkgs.lib.mkForce "/home/${config.my.user.name}";
    extraGroups = [
      "wheel"
      "video"
      "input"
    ];
  };
}
