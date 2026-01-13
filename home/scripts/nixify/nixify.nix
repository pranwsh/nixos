{ config, pkgs, ... }:

let
  mask = ./mask.png;
in {
  home.packages = [
    (pkgs.writeShellScriptBin "nixify" ''
      set -e

      IMG="''$1"
      OUT="''${IMG%.*}-nix.png"
      MASK="${mask}"

      if [ -z "$IMG" ]; then
        echo "Usage: nixify <image>"
        exit 1
      fi

      magick "$IMG" \
        \( +clone -flip "$MASK" -gravity center -geometry +0+0 -compose CopyOpacity -composite \) \
        -gravity center -compose Over -composite \
        "$OUT"

      echo "→ $OUT"
    '')
  ];
}
