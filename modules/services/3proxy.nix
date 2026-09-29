{
  config,
  lib,
  pkgs,
  ...
}:

let
  passwdFile = pkgs.writeText "3proxy.passwd" ''
    test1:CL:password1
  '';
in
{
  services._3proxy = {
    enable = true;
    services = [
      {
        type = "socks";
        auth = [ "strong" ];
        acl = [
          {
            rule = "allow";
            users = [ "test1" ];
          }
        ];
      }
    ];
    usersFile = passwdFile;
  };

  networking.firewall.allowedTCPPorts = [ 1080 ];
}
