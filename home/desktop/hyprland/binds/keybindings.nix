# binds/general-binds.nix
{ lib, ... }:
{
  wayland.windowManager.hyprland.settings = {
    bind = [
      # =========================
      # App launchers
      # =========================
      {
        _args = [
          (lib.generators.mkLuaInline ''mainMod .. " + Q"'')
          (lib.generators.mkLuaInline "hl.dsp.exec_cmd(terminal)")
        ];
      }
      {
        _args = [
          (lib.generators.mkLuaInline ''mainMod .. " + W"'')
          (lib.generators.mkLuaInline "hl.dsp.exec_cmd(browser)")
        ];
      }
      {
        _args = [
          (lib.generators.mkLuaInline ''mainMod .. " + E"'')
          (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("spotify")'')
        ];
      }
      {
        _args = [
          (lib.generators.mkLuaInline ''mainMod .. " + R"'')
          (lib.generators.mkLuaInline "hl.dsp.exec_cmd(menu)")
        ];
      }
      {
        _args = [
          (lib.generators.mkLuaInline ''mainMod .. " + A"'')
          (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("chromium")'')
        ];
      }

      # =========================
      # Window management (general)
      # =========================
      {
        _args = [
          (lib.generators.mkLuaInline ''mainMod .. " + C"'')
          (lib.generators.mkLuaInline "hl.dsp.window.close()")
        ];
      }
      {
        _args = [
          (lib.generators.mkLuaInline ''mainMod .. " + M"'')
          (lib.generators.mkLuaInline "hl.dsp.exit()")
        ];
      }
      {
        _args = [
          (lib.generators.mkLuaInline ''mainMod .. " + V"'')
          (lib.generators.mkLuaInline ''hl.dsp.window.float({ action = "toggle" })'')
        ];
      }

      # =========================
      # Workspace navigation
      # =========================
      {
        _args = [
          (lib.generators.mkLuaInline ''mainMod .. " + Page_Up"'')
          (lib.generators.mkLuaInline ''hl.dsp.focus({ workspace = "e-1" })'')
        ];
      }
      {
        _args = [
          (lib.generators.mkLuaInline ''mainMod .. " + Page_Down"'')
          (lib.generators.mkLuaInline ''hl.dsp.focus({ workspace = "e+1" })'')
        ];
      }

      # =========================
      # Workspace number binds
      # =========================
      {
        _args = [
          (lib.generators.mkLuaInline ''mainMod .. " + 1"'')
          (lib.generators.mkLuaInline "hl.dsp.focus({ workspace = 1 })")
        ];
      }
      {
        _args = [
          (lib.generators.mkLuaInline ''mainMod .. " + 2"'')
          (lib.generators.mkLuaInline "hl.dsp.focus({ workspace = 2 })")
        ];
      }
      {
        _args = [
          (lib.generators.mkLuaInline ''mainMod .. " + 3"'')
          (lib.generators.mkLuaInline "hl.dsp.focus({ workspace = 3 })")
        ];
      }
      {
        _args = [
          (lib.generators.mkLuaInline ''mainMod .. " + 4"'')
          (lib.generators.mkLuaInline "hl.dsp.focus({ workspace = 4 })")
        ];
      }
      {
        _args = [
          (lib.generators.mkLuaInline ''mainMod .. " + 5"'')
          (lib.generators.mkLuaInline "hl.dsp.focus({ workspace = 5 })")
        ];
      }
      {
        _args = [
          (lib.generators.mkLuaInline ''mainMod .. " + 6"'')
          (lib.generators.mkLuaInline "hl.dsp.focus({ workspace = 6 })")
        ];
      }
      {
        _args = [
          (lib.generators.mkLuaInline ''mainMod .. " + 7"'')
          (lib.generators.mkLuaInline "hl.dsp.focus({ workspace = 7 })")
        ];
      }
      {
        _args = [
          (lib.generators.mkLuaInline ''mainMod .. " + 8"'')
          (lib.generators.mkLuaInline "hl.dsp.focus({ workspace = 8 })")
        ];
      }
      {
        _args = [
          (lib.generators.mkLuaInline ''mainMod .. " + 9"'')
          (lib.generators.mkLuaInline "hl.dsp.focus({ workspace = 9 })")
        ];
      }
      {
        _args = [
          (lib.generators.mkLuaInline ''mainMod .. " + 0"'')
          (lib.generators.mkLuaInline "hl.dsp.focus({ workspace = 10 })")
        ];
      }
      {
        _args = [
          (lib.generators.mkLuaInline ''mainMod .. " + S"'')
          (lib.generators.mkLuaInline ''hl.dsp.workspace.toggle_special("magic")'')
        ];
      }

      # Move windows to workspaces
      {
        _args = [
          (lib.generators.mkLuaInline ''mainMod .. " + SHIFT + 1"'')
          (lib.generators.mkLuaInline "hl.dsp.window.move({ workspace = 1 })")
        ];
      }
      {
        _args = [
          (lib.generators.mkLuaInline ''mainMod .. " + SHIFT + 2"'')
          (lib.generators.mkLuaInline "hl.dsp.window.move({ workspace = 2 })")
        ];
      }
      {
        _args = [
          (lib.generators.mkLuaInline ''mainMod .. " + SHIFT + 3"'')
          (lib.generators.mkLuaInline "hl.dsp.window.move({ workspace = 3 })")
        ];
      }
      {
        _args = [
          (lib.generators.mkLuaInline ''mainMod .. " + SHIFT + 4"'')
          (lib.generators.mkLuaInline "hl.dsp.window.move({ workspace = 4 })")
        ];
      }
      {
        _args = [
          (lib.generators.mkLuaInline ''mainMod .. " + SHIFT + 5"'')
          (lib.generators.mkLuaInline "hl.dsp.window.move({ workspace = 5 })")
        ];
      }
      {
        _args = [
          (lib.generators.mkLuaInline ''mainMod .. " + SHIFT + 6"'')
          (lib.generators.mkLuaInline "hl.dsp.window.move({ workspace = 6 })")
        ];
      }
      {
        _args = [
          (lib.generators.mkLuaInline ''mainMod .. " + SHIFT + 7"'')
          (lib.generators.mkLuaInline "hl.dsp.window.move({ workspace = 7 })")
        ];
      }
      {
        _args = [
          (lib.generators.mkLuaInline ''mainMod .. " + SHIFT + 8"'')
          (lib.generators.mkLuaInline "hl.dsp.window.move({ workspace = 8 })")
        ];
      }
      {
        _args = [
          (lib.generators.mkLuaInline ''mainMod .. " + SHIFT + 9"'')
          (lib.generators.mkLuaInline "hl.dsp.window.move({ workspace = 9 })")
        ];
      }
      {
        _args = [
          (lib.generators.mkLuaInline ''mainMod .. " + SHIFT + 0"'')
          (lib.generators.mkLuaInline "hl.dsp.window.move({ workspace = 10 })")
        ];
      }
      {
        _args = [
          (lib.generators.mkLuaInline ''mainMod .. " + SHIFT + S"'')
          (lib.generators.mkLuaInline ''hl.dsp.window.move({ workspace = "special:magic" })'')
        ];
      }

      {
        _args = [
          (lib.generators.mkLuaInline ''mainMod .. " + mouse:272"'')
          (lib.generators.mkLuaInline "hl.dsp.window.drag()")
          { mouse = true; }
        ];
      }
      {
        _args = [
          (lib.generators.mkLuaInline ''mainMod .. " + mouse:273"'')
          (lib.generators.mkLuaInline "hl.dsp.window.resize()")
          { mouse = true; }
        ];
      }
      {
        _args = [
          "XF86AudioRaiseVolume"
          (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+")'')
          {
            release = true;
            locked = true;
          }
        ];
      }
      {
        _args = [
          "XF86AudioLowerVolume"
          (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-")'')
          {
            release = true;
            locked = true;
          }
        ];
      }
      {
        _args = [
          "XF86AudioMute"
          (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle")'')
          {
            release = true;
            locked = true;
          }
        ];
      }
      {
        _args = [
          "XF86AudioMicMute"
          (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle")'')
          {
            release = true;
            locked = true;
          }
        ];
      }
      {
        _args = [
          "XF86MonBrightnessUp"
          (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("brightnessctl s 10%+")'')
          {
            release = true;
            locked = true;
          }
        ];
      }
      {
        _args = [
          "XF86MonBrightnessDown"
          (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("brightnessctl s 10%-")'')
          {
            release = true;
            locked = true;
          }
        ];
      }
      {
        _args = [
          "XF86AudioNext"
          (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("playerctl next")'')
          { locked = true; }
        ];
      }
      {
        _args = [
          "XF86AudioPause"
          (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("playerctl play-pause")'')
          { locked = true; }
        ];
      }
      {
        _args = [
          "XF86AudioPlay"
          (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("playerctl play-pause")'')
          { locked = true; }
        ];
      }
      {
        _args = [
          "XF86AudioPrev"
          (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("playerctl previous")'')
          { locked = true; }
        ];
      }
    ];
  };
}
