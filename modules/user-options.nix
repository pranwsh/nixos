{ lib, ... }:

{
  options.my.user = {
    name = lib.mkOption {
      type = lib.types.str;
      default = "pranesh";
      description = "The primary username for the system";
    };
    email = lib.mkOption {
      type = lib.types.str;
      default = "praneshk119@gmail.com";
      description = "The email address for the user";
    };
    fullName = lib.mkOption {
      type = lib.types.str;
      default = "Pranesh";
      description = "The full name of the user";
    };
    zenProfileName = lib.mkOption {
      type = lib.types.str;
      default = "ro4rmu9s.Default Profile";
      description = "The profile name for Zen browser";
    };
  };
}
