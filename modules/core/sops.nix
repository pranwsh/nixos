{ config, pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.sops
    pkgs.age
  ];

  sops = {
    defaultSopsFile = ../../secrets.yaml;
    defaultSopsFormat = "yaml";
    age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];

    secrets = {
      nvidia_key = {
        owner = config.my.user.name;
        group = "users";
        mode = "0440";
      };
      mistral_key = {
        owner = config.my.user.name;
        group = "users";
        mode = "0440";
      };
      tokenrouter_key = {
        owner = config.my.user.name;
        group = "users";
        mode = "0440";
      };
      inferx_key = {
        owner = config.my.user.name;
        group = "users";
        mode = "0440";
      };
    };
  };
}
