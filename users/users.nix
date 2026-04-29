{
  config,
  ...
}:
{
  users.users."${config.my.user.name}" = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "video"
      "input"
    ];
  };
}
