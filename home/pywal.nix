{ config, pkgs, lib, ... }:

let
  wallpaper = config.style.wallpaperPath;

  walJson = pkgs.runCommand "wal-colors-json" { buildInputs = [ pkgs.pywal ]; } ''
    export HOME="$TMPDIR"
    wal -i ${wallpaper} -n -q
    mkdir -p "$out"
    cp "$HOME/.cache/wal/colors.json" "$out/colors.json"
  '';

  walNix = pkgs.runCommand "wal-colors-nix" { buildInputs = [ pkgs.python3 ]; } ''
    mkdir -p "$out"
    export OUTFILE="$out/colors.nix"

    ${pkgs.python3}/bin/python - <<'PY'
import os, json, pathlib

data = json.load(open("${walJson}/colors.json"))
special = data.get("special", {}) or {}
colorsD = data.get("colors", {}) or {}

def get(d, k, default="#000000"):
  v = d.get(k)
  return (v if v else default).lower()

cols = [get(colorsD, f"color{i}") for i in range(16)]

out = []
out.append("{")
out.append("  colorscheme = {")
out.append(f'    background = "{get(special, "background")}";')
out.append(f'    foreground = "{get(special, "foreground")}";')
out.append(f'    cursor = "{get(special, "cursor", get(special, "foreground"))}";')
for i in range(16):
  out.append(f'    color{i} = "{cols[i]}";')
out.append("  };")
out.append("}")

pathlib.Path(os.environ["OUTFILE"]).write_text("\n".join(out) + "\n")
PY
  '';
in
{
  home.packages = with pkgs; [
    pywal
  ];

  # home.file.".config/wal/colors.nix".source = "${walNix}/colors.nix";

  _module.args.walNix = walNix;
}


