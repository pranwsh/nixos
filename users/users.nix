{
  config,
  lib,
  pkgs,
  ...
}: {
  users.users."${config.my.user.name}" = {
    isNormalUser = true;
    extraGroups = ["wheel" "video" "input"];
    packages = with pkgs; [];
  };
}
