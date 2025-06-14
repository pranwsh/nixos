{ config, lib, pkgs, ... }:

{
  security.pam.services.login.startSession = true;
}
