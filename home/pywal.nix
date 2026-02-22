{
  config,
  pkgs,
  ...
}: let
  wallpaper = config.style.wallpaperPath;
  saturate = "0.6";
  walNix = pkgs.runCommand "wal-colors-nix" {buildInputs = [pkgs.pywal pkgs.python3];} ''
    export HOME="$TMPDIR"
    wal -i ${wallpaper} -n -q --saturate ${saturate}
    mkdir -p "$out"
    ${pkgs.python3}/bin/python - <<'PY'
    import os, json, pathlib
    data = json.load(open(os.path.expanduser("~/.cache/wal/colors.json")))
    special = data.get("special", {})
    colorsD = data.get("colors", {})
    def get(d, k, default="#000000"):
        v = d.get(k)
        return (v if v else default).lower()
    bg     = get(special, "background")
    fg     = get(special, "foreground")
    cursor = get(special, "cursor", fg)
    out = ["{", "  colorscheme = {"]
    out.append(f'    background = "{bg}";')
    out.append(f'    foreground = "{fg}";')
    out.append(f'    cursor = "{cursor}";')
    for i in range(16):
        out.append(f'    color{i} = "{get(colorsD, f"color{i}")}";')
    out.append("  };")
    out.append("}")
    pathlib.Path(os.environ["out"] + "/colors.nix").write_text("\n".join(out) + "\n")
    PY
  '';
in {
  home.packages = with pkgs; [pywal];
  _module.args.walNix = walNix;
}
