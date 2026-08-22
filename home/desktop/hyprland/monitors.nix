{
  config,
  ...
}: {
  wayland.windowManager.hyprland.extraConfig = ''
    local wp = "${toString config.style.wallpaperPath}"

    local function configureMonitors()
      hl.monitor({ output = "HDMI-A-1", mode = "2560x1080@74.99", position = "auto", scale = 1, disabled = false })
      hl.timer(function()
        local docked = false
        for _, m in ipairs(hl.get_monitors() or {}) do
          if m.name == "HDMI-A-1" then docked = true end
        end
        if docked then
          hl.monitor({ output = "eDP-1", disabled = true })
        else
          hl.monitor({ output = "eDP-1", mode = "preferred", position = "auto", scale = 1, disabled = false })
          hl.monitor({ output = "HDMI-A-1", disabled = true })
        end
        hl.timer(function()
          local monitor = docked and "HDMI-A-1" or "eDP-1"
          hl.exec_cmd("hyprctl hyprpaper wallpaper " .. monitor .. "," .. wp .. ",cover")
        end, { timeout = 300, type = "oneshot" })
      end, { timeout = 1000, type = "oneshot" })
    end

    configureMonitors()

    hl.on("monitor.layout_changed", function()
      hl.timer(configureMonitors, { timeout = 300, type = "oneshot" })
    end)
  '';
}