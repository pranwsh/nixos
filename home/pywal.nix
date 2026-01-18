{ config, pkgs, lib, ... }:
let
  wallpaper = config.style.wallpaperPath;
  
  # Vibrancy control: 0.0 = grayscale, 1.0 = original saturation, >1.0 = boosted saturation
  # Can go higher than 1.0 for extra vibrant colors (e.g., 1.5, 2.0)
  vibrancy = 1.4;
  
  # Target lightness for normalization (0.0 = black, 1.0 = white)
  # Colors will be adjusted to match this lightness while preserving hue
  targetLightness = 0.75;
  
  walJson = pkgs.runCommand "wal-colors-json" { buildInputs = [ pkgs.pywal ]; } ''
    export HOME="$TMPDIR"
    wal -i ${wallpaper} -n -q --saturate 0.6
    mkdir -p "$out"
    cp "$HOME/.cache/wal/colors.json" "$out/colors.json"
  '';
  
  walNix = pkgs.runCommand "wal-colors-nix" { buildInputs = [ pkgs.python3 ]; } ''
    mkdir -p "$out"
    export OUTFILE="$out/colors.nix"
    export VIBRANCY="${toString vibrancy}"
    export TARGET_LIGHTNESS="${toString targetLightness}"
    ${pkgs.python3}/bin/python - <<'PY'
import os, json, pathlib, colorsys

data = json.load(open("${walJson}/colors.json"))
special = data.get("special", {}) or {}
colorsD = data.get("colors", {}) or {}

vibrancy = float(os.environ.get("VIBRANCY", "0.8"))
target_lightness = float(os.environ.get("TARGET_LIGHTNESS", "0.65"))

def hex_to_rgb(hex_color):
    """Convert hex color to RGB tuple (0-1 range)"""
    hex_color = hex_color.lstrip('#')
    return tuple(int(hex_color[i:i+2], 16) / 255.0 for i in (0, 2, 4))

def rgb_to_hex(r, g, b):
    """Convert RGB (0-1 range) to hex color"""
    return "#{:02x}{:02x}{:02x}".format(
        int(r * 255), int(g * 255), int(b * 255)
    )

def normalize_color(hex_color, target_light, vibr):
    """Normalize color to target lightness and vibrancy"""
    if not hex_color or hex_color == "#000000":
        return "#000000"
    
    r, g, b = hex_to_rgb(hex_color)
    h, l, s = colorsys.rgb_to_hls(r, g, b)
    
    # Adjust saturation based on vibrancy setting
    # Clamp to max 1.0 to avoid invalid colors
    s = min(s * vibr, 1.0)
    
    # Set lightness to target value
    l = target_light
    
    # Convert back to RGB
    r, g, b = colorsys.hls_to_rgb(h, l, s)
    
    return rgb_to_hex(r, g, b)

def get(d, k, default="#000000"):
    v = d.get(k)
    return (v if v else default).lower()

# Special colors (background/foreground) kept as-is or with minimal adjustment
bg = get(special, "background")
fg = get(special, "foreground")
cursor = get(special, "cursor", fg)

out = []
out.append("{")
out.append("  colorscheme = {")
out.append(f'    background = "{bg}";')
out.append(f'    foreground = "{fg}";')
out.append(f'    cursor = "{cursor}";')

# Normalize color0-15
for i in range(16):
    original = get(colorsD, f"color{i}")
    normalized = normalize_color(original, target_lightness, vibrancy)
    out.append(f'    color{i} = "{normalized}";')

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
  _module.args.walNix = walNix;
}
