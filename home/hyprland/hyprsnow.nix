{ config, lib, pkgs, ... }:

let
  cfg = config.programs.hyprsnow;

  hyprsnowPkg = pkgs.rustPlatform.buildRustPackage {
    pname = "hyprsnow";
    version = "0.1.1";

    # From crates.io
    src = pkgs.fetchCrate {
      inherit pname version;
      sha256 = lib.fakeSha256;   # <- temporary, will fix after first build
    };

    cargoHash = lib.fakeSha256;  # <- same deal, fix after first build
    doCheck = false;
  };
in {
  options.programs.hyprsnow = {
    enable = lib.mkEnableOption "hyprsnow snow overlay for Hyprland";

    package = lib.mkOption {
      type = lib.types.package;
      default = hyprsnowPkg;
      description = "hyprsnow package to install.";
    };

    intensity = lib.mkOption {
      type = lib.types.int;
      default = 5;
      description = "Snow intensity 1–10.";
    };

    sizeMin = lib.mkOption {
      type = lib.types.float;
      default = 2.0;
      description = "Minimum snowflake size in pixels.";
    };

    sizeMax = lib.mkOption {
      type = lib.types.float;
      default = 5.0;
      description = "Maximum snowflake size in pixels.";
    };

    speedMin = lib.mkOption {
      type = lib.types.float;
      default = 30.0;
      description = "Minimum fall speed in pixels/second.";
    };

    speedMax = lib.mkOption {
      type = lib.types.float;
      default = 80.0;
      description = "Maximum fall speed in pixels/second.";
    };

    drift = lib.mkOption {
      type = lib.types.float;
      default = 20.0;
      description = "Horizontal drift intensity (0–30).";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ cfg.package ];

    # This writes ~/.config/hypr/hyprsnow.conf
    xdg.configFile."hypr/hyprsnow.conf".text = ''
      general {
        intensity = ${toString cfg.intensity}
        size_min = ${toString cfg.sizeMin}
        size_max = ${toString cfg.sizeMax}
        speed_min = ${toString cfg.speedMin}
        speed_max = ${toString cfg.speedMax}
        drift = ${toString cfg.drift}
      }
    '';
  };
}
