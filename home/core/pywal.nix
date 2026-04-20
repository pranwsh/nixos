{
  config,
  pkgs,
  ...
}: let
  wallpaper = config.style.wallpaperPath;

  # Target perceptual lightness for background (0–1)
  bgTarget = "0.13";
  # Target lightness for foreground text
  fgTarget = "0.88";
  # Target lightness for accent colors (color1–color6)
  accentTarget = "0.65";
  # Saturation scale for accents (1.0 = full wal saturation)
  accentSat = "0.75";
  # Target lightness for dim/ui colors (color8–color15)
  dimTarget = "0.50";
  dimSat = "0.45";

  walNix = pkgs.runCommand "wal-colors-nix" {buildInputs = [pkgs.pywal pkgs.python3];} ''
        export HOME="$TMPDIR"
        wal -i ${wallpaper} -n -q
        mkdir -p "$out"
        ${pkgs.python3}/bin/python - <<'PY'
    import os, json, pathlib, colorsys

    data = json.load(open(os.path.expanduser("~/.cache/wal/colors.json")))
    special = data.get("special", {})
    colors  = data.get("colors", {})

    bg_target     = float("${bgTarget}")
    fg_target     = float("${fgTarget}")
    accent_target = float("${accentTarget}")
    accent_sat    = float("${accentSat}")
    dim_target    = float("${dimTarget}")
    dim_sat       = float("${dimSat}")

    def get(d, k, default="#000000"):
        v = d.get(k)
        return (v if v else default).lower()

    def parse(hex_color):
        h = hex_color.lstrip("#")
        r, g, b = (int(h[i:i+2], 16) / 255.0 for i in (0, 2, 4))
        hue, l, s = colorsys.rgb_to_hls(r, g, b)
        return hue, l, s

    def to_hex(hue, l, s):
        l = max(0.0, min(1.0, l))
        s = max(0.0, min(1.0, s))
        r, g, b = colorsys.hls_to_rgb(hue, l, s)
        return "#{:02x}{:02x}{:02x}".format(int(r * 255), int(g * 255), int(b * 255))

    def push_toward(val, target, strength=0.85):
        """Blend val toward target by strength (0=no change, 1=full target)."""
        return val + (target - val) * strength

    # --- Background: very dark, low saturation, keep hue from wallpaper ---
    def adjust_bg(hex_color):
        hue, l, s = parse(hex_color)
        l = push_toward(l, bg_target, 0.92)
        s = s * 0.30  # nearly desaturated so text is readable on it
        return to_hex(hue, l, s)

    # --- Foreground: bright, very low saturation (near-white with tint) ---
    def adjust_fg(hex_color):
        hue, l, s = parse(hex_color)
        l = push_toward(l, fg_target, 0.90)
        s = s * 0.15  # slight tint from wallpaper hue, mostly neutral
        return to_hex(hue, l, s)

    # --- Accent colors (color1–color6): mid-light, punchy saturation ---
    def adjust_accent(hex_color):
        hue, l, s = parse(hex_color)
        l = push_toward(l, accent_target, 0.80)
        s = push_toward(s, accent_sat, 0.70)
        return to_hex(hue, l, s)

    # --- Dim/UI colors (color8–color15): muted, readable as secondary text ---
    def adjust_dim(hex_color):
        hue, l, s = parse(hex_color)
        l = push_toward(l, dim_target, 0.75)
        s = push_toward(s, dim_sat, 0.60)
        return to_hex(hue, l, s)

    # color0 = terminal black; make it slightly lighter than bg for selection bg
    def adjust_color0(hex_color, bg_hex):
        hue, l, s = parse(bg_hex)
        return to_hex(hue, l + 0.06, s * 0.50)

    # color7 = terminal white; same as foreground but slightly dimmer
    def adjust_color7(hex_color):
        hue, l, s = parse(hex_color)
        l = push_toward(l, fg_target - 0.10, 0.85)
        s = s * 0.18
        return to_hex(hue, l, s)

    bg_raw  = get(special, "background")
    fg_raw  = get(special, "foreground")
    cur_raw = get(special, "cursor", fg_raw)

    bg_hex  = adjust_bg(bg_raw)
    fg_hex  = adjust_fg(fg_raw)
    cur_hex = adjust_fg(cur_raw)

    out = ["{", "  colorscheme = {"]
    out.append(f'    background = "{bg_hex}";')
    out.append(f'    foreground = "{fg_hex}";')
    out.append(f'    cursor     = "{cur_hex}";')

    for i in range(16):
        raw = get(colors, f"color{i}")
        if i == 0:
            out.append(f'    color{i}  = "{adjust_color0(raw, bg_raw)}";')
        elif i == 7:
            out.append(f'    color{i}  = "{adjust_color7(raw)}";')
        elif 1 <= i <= 6:
            out.append(f'    color{i}  = "{adjust_accent(raw)}";')
        else:  # 8–15
            out.append(f'    color{i} = "{adjust_dim(raw)}";')

    out.append("  };")
    out.append("}")
    pathlib.Path(os.environ["out"] + "/colors.nix").write_text("\n".join(out) + "\n")
    PY
  '';
in {
  home.packages = with pkgs; [pywal];
  _module.args.walNix = walNix;
}
