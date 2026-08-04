{
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    hyprshot
  ];

  home.file."Pictures/Screenshots/.keep".text = "";

  wayland.windowManager.hyprland.settings = {
    bind = [
      {
        _args = [
          (lib.generators.mkLuaInline ''mainMod .. " + Z"'')
          (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("${pkgs.hyprshot}/bin/hyprshot -m output -o ~/Pictures/Screenshots")'')
        ];
      }

      {
        _args = [
          (lib.generators.mkLuaInline ''mainMod .. " + SHIFT + Z"'')
          (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("${pkgs.hyprshot}/bin/hyprshot -m window -o ~/Pictures/Screenshots")'')
        ];
      }

      {
        _args = [
          (lib.generators.mkLuaInline ''mainMod .. " + CTRL + Z"'')
          (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("${pkgs.hyprshot}/bin/hyprshot -m region -o ~/Pictures/Screenshots")'')
        ];
      }
    ];
  };
}
