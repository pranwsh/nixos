{ lib, fetchFromGitHub, hyprland, hyprlandPlugins }:
hyprlandPlugins.mkHyprlandPlugin (finalAttrs: {
  pluginName = "hyprglass";
  # Tracking upstream main (user choice). Pinned to an immutable commit
  # for reproducibility — update rev + hash together to follow main.
  # Pinned: 2026-09-03, upstream v0.8.1, .hyprland-version = 0.56.2.
  # Matches running Hyprland 0.56.2 (efb5099...). If Hyprland updates and
  # the plugin fails with a version mismatch, re-pin to the commit in
  # hyprpm.toml `commit_pins` matching the new Hyprland commit.
  version = "unstable-2026-09-03";

  src = fetchFromGitHub {
    owner = "hyprnux";
    repo = "hyprglass";
    rev = "725383e86a2a79457a81cdbc2ceb33c07363bd8d";
    hash = "sha256-yUU0gKu1CXqpUQBtyb3IWNBYZ1bCAm99mfTUV7ceJyg=";
  };

  # Makefile-based build (`make` -> hyprglass.so) using
  # `pkg-config --cflags hyprland pixman-1 libdrm`.
  # mkHyprlandPlugin already provides pkg-config, the compiler
  # (via hyprland.stdenv), plus hyprland and its buildInputs.
  nativeBuildInputs = [];
  buildInputs = [];

  # Upstream Makefile has no `install` target (only builds ./hyprglass.so),
  # so install the plugin where home-manager expects it:
  # $out/lib/lib<pluginName>.so
  installPhase = ''
    runHook preInstall
    mkdir -p $out/lib
    cp hyprglass.so $out/lib/lib${finalAttrs.pluginName}.so
    runHook postInstall
  '';

  meta = {
    homepage = "https://github.com/hyprnux/hyprglass";
    description = "Liquid Glass blur/refraction plugin for Hyprland";
    license = lib.licenses.bsd3;
    platforms = lib.platforms.linux;
  };
})
