{ pkgs, ... }:
{
  wayland.windowManager.hyprland.plugins = [
    (pkgs.callPackage ./hyprglass.nix { })
  ];

  # Minimal hyprglass config (upstream Lua API). Layers stay disabled
  # (upstream default). Plugin must be loaded before configuring,
  # hence the guard; extraConfig is appended after plugin load lines.
  wayland.windowManager.hyprland.extraConfig = ''
    if hl.plugin.hyprglass then
      local hg = hl.plugin.hyprglass
      hg.config({
        default_theme = "dark",
        default_preset = "clear",
      })
    end
  '';
}
