{ lib, ... }: {
  wayland.windowManager.hyprland.settings = {
    bind = [
      # =========================
      # Focus move
      # =========================
      {
        _args = [
          (lib.generators.mkLuaInline ''mainMod .. " + h"'')
          (lib.generators.mkLuaInline ''hl.dsp.focus({ direction = "left" })'')
        ];
      }
      {
        _args = [
          (lib.generators.mkLuaInline ''mainMod .. " + l"'')
          (lib.generators.mkLuaInline ''hl.dsp.focus({ direction = "right" })'')
        ];
      }
      {
        _args = [
          (lib.generators.mkLuaInline ''mainMod .. " + k"'')
          (lib.generators.mkLuaInline ''hl.dsp.focus({ direction = "up" })'')
        ];
      }
      {
        _args = [
          (lib.generators.mkLuaInline ''mainMod .. " + j"'')
          (lib.generators.mkLuaInline ''hl.dsp.focus({ direction = "down" })'')
        ];
      }
      # =========================
      # Move window
      # =========================
      {
        _args = [
          (lib.generators.mkLuaInline ''mainMod .. " + SHIFT + h"'')
          (lib.generators.mkLuaInline ''hl.dsp.window.move({ direction = "left" })'')
        ];
      }
      {
        _args = [
          (lib.generators.mkLuaInline ''mainMod .. " + SHIFT + l"'')
          (lib.generators.mkLuaInline ''hl.dsp.window.move({ direction = "right" })'')
        ];
      }
      {
        _args = [
          (lib.generators.mkLuaInline ''mainMod .. " + SHIFT + k"'')
          (lib.generators.mkLuaInline ''hl.dsp.window.move({ direction = "up" })'')
        ];
      }
      {
        _args = [
          (lib.generators.mkLuaInline ''mainMod .. " + SHIFT + j"'')
          (lib.generators.mkLuaInline ''hl.dsp.window.move({ direction = "down" })'')
        ];
      }

      # =========================
      # Groups (Hyprland native tabs)
      # =========================
      {
        _args = [
          (lib.generators.mkLuaInline ''mainMod .. " + t"'')
          (lib.generators.mkLuaInline "hl.dsp.group.toggle()")
        ];
      }
      {
        _args = [
          (lib.generators.mkLuaInline ''mainMod .. " + tab"'')
          (lib.generators.mkLuaInline "hl.dsp.group.next()")
        ];
      }
      {
        _args = [
          (lib.generators.mkLuaInline ''mainMod .. " + CTRL + tab"'')
          (lib.generators.mkLuaInline "hl.dsp.group.prev()")
        ];
      }
      {
        _args = [
          (lib.generators.mkLuaInline ''mainMod .. " + CTRL + H"'')
          (lib.generators.mkLuaInline ''hl.dsp.window.move({ into_group = "left" })'')
        ];
      }
      {
        _args = [
          (lib.generators.mkLuaInline ''mainMod .. " + CTRL + L"'')
          (lib.generators.mkLuaInline ''hl.dsp.window.move({ into_group = "right" })'')
        ];
      }
      {
        _args = [
          (lib.generators.mkLuaInline ''mainMod .. " + CTRL + K"'')
          (lib.generators.mkLuaInline ''hl.dsp.window.move({ into_group = "up" })'')
        ];
      }
      {
        _args = [
          (lib.generators.mkLuaInline ''mainMod .. " + CTRL + J"'')
          (lib.generators.mkLuaInline ''hl.dsp.window.move({ into_group = "down" })'')
        ];
      }
      {
        _args = [
          (lib.generators.mkLuaInline ''mainMod .. " + P"'')
          (lib.generators.mkLuaInline "hl.dsp.window.move({ out_of_group = true })")
        ];
      }
      {
        _args = [
          (lib.generators.mkLuaInline ''mainMod .. " + L"'')
          (lib.generators.mkLuaInline "hl.dsp.group.lock_active()")
        ];
      }
    ];
  };
}
