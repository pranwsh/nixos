{ config, pkgs, lib, ... }:

let
  wallpaper = ./wallpapers/robots.png;

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
import os, json, pathlib, colorsys

data = json.load(open("${walJson}/colors.json"))
special = data.get("special", {})
colorsD = data.get("colors", {})

def get(d, k, default="#000000"):
  v = d.get(k)
  return v if v else default

def hex_to_rgb01(h):
  h = h.lstrip("#")
  r = int(h[0:2], 16) / 255.0
  g = int(h[2:4], 16) / 255.0
  b = int(h[4:6], 16) / 255.0
  return r, g, b

def rgb01_to_hex(rgb):
  r,g,b = rgb
  r = int(round(max(0,min(1,r)) * 255))
  g = int(round(max(0,min(1,g)) * 255))
  b = int(round(max(0,min(1,b)) * 255))
  return f"#{r:02x}{g:02x}{b:02x}"

def lighten_hex(hexcol, amt):
  # blend toward white by amt in [0,1]
  r,g,b = hex_to_rgb01(hexcol)
  r = r + (1.0 - r) * amt
  g = g + (1.0 - g) * amt
  b = b + (1.0 - b) * amt
  return rgb01_to_hex((r,g,b))

def clamp01(x): return max(0.0, min(1.0, x))

# thresholds: tune these if you want
S_MIN = 0.28   # below this is "too grey"
V_MIN = 0.26   # below this is "too dark"
# how aggressively we fix
SAT_BOOST = 0.35
VAL_BOOST = 0.22
HUE_PULL  = 0.65  # 0..1, closer to 1 = follow accent hue more

# Read pywal colors
cols = [get(colorsD, f"color{i}") for i in range(16)]

# Find an accent hue: most saturated color in palette
accent_h = None
accent_s = -1.0
for hx in cols:
  r,g,b = hex_to_rgb01(hx)
  h,s,v = colorsys.rgb_to_hsv(r,g,b)
  if s > accent_s and v > 0.20:  # ignore near-black
    accent_s = s
    accent_h = h
if accent_h is None:
  accent_h = 0.58  # fallback (blue-ish)

def fix_color(hexcol):
  r,g,b = hex_to_rgb01(hexcol)
  h,s,v = colorsys.rgb_to_hsv(r,g,b)

  changed = False

  # Fix darkness
  if v < V_MIN:
    v = clamp01(v + VAL_BOOST + (V_MIN - v) * 0.75)
    changed = True

  # Fix greyness (low saturation)
  if s < S_MIN:
    # pull hue toward accent + increase saturation
    # handle hue wrap-around by just interpolating; good enough for this use
    h = (h * (1.0 - HUE_PULL) + accent_h * HUE_PULL) % 1.0
    s = clamp01(s + SAT_BOOST + (S_MIN - s) * 0.90)
    changed = True

  if not changed:
    return hexcol.lower()

  rr,gg,bb = colorsys.hsv_to_rgb(h,s,v)
  return rgb01_to_hex((rr,gg,bb))

# Apply fixes.
# Keep background mostly as-is (only prevent it from being unusably dark/grey).
bg = get(special, "background")
fg = get(special, "foreground")
cur = get(special, "cursor", fg)

bg_fixed = fix_color(bg)
# if background got too colorful, back it off slightly by mixing toward original
# (keeps "background" behaving like a background)
def mix(a, b, t):
  ar,ag,ab = hex_to_rgb01(a); br,bg,bb = hex_to_rgb01(b)
  return rgb01_to_hex((ar*(1-t)+br*t, ag*(1-t)+bg*t, ab*(1-t)+bb*t))
bg_fixed = mix(bg, bg_fixed, 0.55)

fg_fixed  = fix_color(fg)
cur_fixed = fix_color(cur)

cols_fixed = [fix_color(c) for c in cols]

# Also keep the bright set distinct-ish from normal set:
# if color8..15 collide with 0..7, lighten them.
used = set(c.lower() for c in cols_fixed[:8])
for i in range(8, 16):
  if cols_fixed[i].lower() in used or cols_fixed[i].lower() == cols_fixed[i-8].lower():
    cols_fixed[i] = lighten_hex(cols_fixed[i-8], 0.22 + 0.04*(i-8))
  used.add(cols_fixed[i].lower())

out = []
out.append("{")
out.append("  colorscheme = {")
out.append(f'    background = "{bg_fixed}";')
out.append(f'    foreground = "{fg_fixed}";')
out.append(f'    cursor = "{cur_fixed}";')
for i in range(16):
  out.append(f'    color{i} = "{cols_fixed[i]}";')
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

  home.file.".config/wal/colors.nix".source = "${walNix}/colors.nix";

  _module.args.walNix = walNix;
}
