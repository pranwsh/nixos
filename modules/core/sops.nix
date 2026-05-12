{ config, ... }: {
  sops = {
    defaultSopsFile = ../../secrets.yaml;
    defaultSopsFormat = "yaml";
    age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];

    secrets = {
      deepseek_key = { };
      nvidia_key = { };
      mistral_key = { };
    };
  };
}
