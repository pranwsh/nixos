{ config, pkgs, ... }: {
  services.greetd = {
    enable = true;

    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --cmd Hyprland";
        user = "greeter";
      };
    };
  };

  users.users.greeter = {
    isSystemUser = true;
    group = "greeter";
    shell = pkgs.bash;
  };

  users.groups.greeter = {};
}
