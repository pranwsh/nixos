{ config, pkgs, ... }:

{
  home.packages = [
    (pkgs.writeShellScriptBin "nixify" ''
      set -e

      IMG="''$1"
      MASK="''$2"
      OUT="''$3"

      if [ -z "$IMG" ] || [ -z "$MASK" ] || [ -z "$OUT" ]; then
        echo "Usage: nixify <image> <mask> <output>"
        exit 1
      fi

      magick "$IMG" \
        \( +clone -flip "$MASK" -gravity center -geometry +0+0 -compose CopyOpacity -composite \) \
        -gravity center -compose Over -composite \
        "$OUT"
    '')
  ];
}
