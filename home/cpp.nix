{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.cpp.dev;
in
{
  options.cpp.dev = {
    enable = mkEnableOption "C++ development environment";

    extraPackages = mkOption {
      type = types.listOf types.package;
      default = [];
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      gcc
      clang

      cmake
      meson
      ninja

      gdb
      lldb
      valgrind

      googletest

      clang-tools
      cppcheck
    ] ++ cfg.extraPackages;
  };
}
