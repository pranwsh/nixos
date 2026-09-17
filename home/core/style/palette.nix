# Pure eval-time palette generator using pywal16.
#
# Called by default.nix when style.enablePywal is true. Runs at Nix
# evaluation time (import-from-derivation), not as a daemon, so a changed
# wallpaper file produces a new store path and automatically regenerates
# the 16-color palette on the next rebuild — no manual step, no
# self-modifying source files.
#
# Args:
#   pkgs      — nixpkgs, for pywal16 + imagemagick (backend dependency)
#   wallpaper — Nix path to the image (store-copied, so content changes
#               change the derivation hash and trigger a rebuild)
#   backend   — pywal backend; "wal" works headless in the sandbox.
#               Others (colorthief, haishoku, …) also work if their
#               dependencies are available at build time.
#
# Returns: { colors } where colors is
# { color0 .. color15 } mapped straight from pywal's colors.json.
# Note: pywal's special.background/foreground are intentionally ignored —
# background/foreground stay hand-set in default.nix; only the 16-color
# palette comes from pywal.
{ pkgs, wallpaper, backend ? "wal" }:
let
  colorsFile = pkgs.runCommand "pywal-palette-colors.json" {
    buildInputs = [
      pkgs.pywal16
      pkgs.imagemagick
    ];
  } ''
    export HOME="$TMPDIR"
    export XDG_CACHE_HOME="$TMPDIR/.cache"
    export XDG_CONFIG_HOME="$TMPDIR/.config"
    mkdir -p "$XDG_CACHE_HOME" "$XDG_CONFIG_HOME"
    # -n: don't set wallpaper, -s/-t/-e: skip terminal/tty/reload side effects,
    # -q: quiet. Output lands in $XDG_CACHE_HOME/wal/colors.json.
    wal -i ${wallpaper} -n -q -s -t -e --backend ${backend}
    cp "$XDG_CACHE_HOME/wal/colors.json" "$out"
  '';
  # readFile keeps the derivation's store context on the string, which
  # fromJSON rejects ("not allowed to refer to a store path"). Discard it:
  # the content is pure data (hex strings), and the wallpaper -> derivation
  # dependency is already recorded by the ${wallpaper} / ${colorsFile}
  # references above, so rebuilds still trigger on wallpaper changes.
  data = builtins.fromJSON (builtins.unsafeDiscardStringContext (builtins.readFile "${colorsFile}"));
in
{
  colors = data.colors;
}
