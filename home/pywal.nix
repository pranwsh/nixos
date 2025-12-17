{ config, pkgs, lib, ... }:

let
  wallpaper = /home/pranesh/Pictures/Wallpapers/newer/a_planet_in_the_sky.jpg;

  walJson = pkgs.runCommand "wal-colors-json" { buildInputs = [ pkgs.pywal ]; } ''
    export HOME="$TMPDIR"
    wal -i ${wallpaper} -n -q
    mkdir -p "$out"
    cp "$HOME/.cache/wal/colors.json" "$out/colors.json"
  '';

  walNix = pkgs.runCommand "wal-colors-nix" { buildInputs = [ pkgs.python3 ]; } ''
    mkdir -p "$out"
    ${pkgs.python3}/bin/python - <<'PY'
import json, pathlib
data = json.load(open("${walJson}/colors.json"))
special = data.get("special", {})
colors  = data.get("colors", {})

def get(d, k, default="#000000"):
  return d.get(k) or default

lines = []
lines.append("{")
lines.append("  colorscheme = {")
lines.append(f'    background = "{get(special,"background")}";')
lines.append(f'    foreground = "{get(special,"foreground")}";')
lines.append(f'    cursor = "{get(special,"cursor", get(special,"foreground"))}";')
for i in range(16):
  lines.append(f'    color{i} = "{get(colors, f"color{i}")}";')
lines.append("  };")
lines.append("}")
pathlib.Path("$out/colors.nix").write_text("\n".join(lines) + "\n")
PY
  '';
in
{
  home.packages = with pkgs; [
    pywal
  ];

  # This will appear at: ~/.config/wal/colors.nix
  home.file.".config/wal/colors.nix".source = "${walNix}/colors.nix";
}
