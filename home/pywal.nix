{ config, pkgs, lib, ... }:
let
  wallpaper = config.style.wallpaperPath;
  walJson = pkgs.runCommand "wal-colors-json" { buildInputs = [ pkgs.pywal ]; } ''
    export HOME="$TMPDIR"
    wal -i ${wallpaper} -n -q --saturate 0.6
    mkdir -p "$out"
    cp "$HOME/.cache/wal/colors.json" "$out/colors.json"
  '';
  walNix = pkgs.runCommand "wal-colors-nix" { buildInputs = [ pkgs.python3 ]; } ''
    mkdir -p "$out"
    export OUTFILE="$out/colors.nix"
    ${pkgs.python3}/bin/python - <<'PY'
import os, json, pathlib, colorsys

def saturate_color(hex_color, factor=1.5):
    """Increase saturation of a hex color"""
    hex_color = hex_color.lstrip('#')
    r, g, b = tuple(int(hex_color[i:i+2], 16) / 255.0 for i in (0, 2, 4))
    h, s, v = colorsys.rgb_to_hsv(r, g, b)
    s = min(1.0, s * factor)
    r, g, b = colorsys.hsv_to_rgb(h, s, v)
    return f"#{int(r*255):02x}{int(g*255):02x}{int(b*255):02x}"

data = json.load(open("${walJson}/colors.json"))
special = data.get("special", {}) or {}
colorsD = data.get("colors", {}) or {}

def get(d, k, default="#000000"):
  v = d.get(k)
  return (v if v else default).lower()

cols = [saturate_color(get(colorsD, f"color{i}"), factor=1.5) for i in range(16)]
out = []
out.append("{")
out.append("  colorscheme = {")
out.append(f'    background = "{get(special, "background")}";')
out.append(f'    foreground = "{get(special, "foreground")}";')
out.append(f'    cursor = "{saturate_color(get(special, "cursor", get(special, "foreground")), factor=1.3)}";')
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
