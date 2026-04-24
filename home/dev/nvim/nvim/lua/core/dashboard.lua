-- lua/core/dashboard.lua
local M = {}

function M.setup()
  local function draw_ascii()
    local art = {
      "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣠⠤⢾⣞⣿⣿⣿⣶",
      "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⡤⠔⠚⠉⢁⣤⣶⣾⣿⣟⠻⢇⣿",
      "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⡤⠒⠋⠉⠀⠀⠀⣠⣶⣿⣿⡿⢋⡴⠟⣾⡾⠉",
      "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⡴⠚⠁⠀⠀⠀⠀⣠⣴⣾⣿⢟⡿⢋⡴⠛⣠⢾⠏⠁⠀",
      "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡴⠚⠁⠀⠀⠀⠀⢠⣾⣿⠿⡟⢋⠔⢁⣴⠟⢁⡴⣱⠋⠀⠀⠀",
      "⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡶⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡴⠋⠀⠀⠀⠀⣤⢶⣶⣾⡟⢠⠋⢠⠏⡰⢻⠋⡠⢋⡞⠁⠀⠀⠀⠀",
      "⡏⢧⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⡿⠀⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡴⠋⠀⢀⣰⣶⣿⣷⣇⣾⣿⢿⣤⠃⢠⢏⡞⣡⢃⣞⣡⠋⠀⠀⠀⠀⠀⠀",
      "⡇⠈⠈⠳⢦⡀⠀⠀⢀⣤⣠⣴⠗⠛⠀⢠⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡴⠋⠀⠀⣴⠋⠁⣠⣿⣿⣿⢟⣽⡿⢃⡴⢃⠞⣰⣿⣿⠟⠁⠀⠀⠀⠀⠀⠀⠀",
      "⢻⡄⠀⠀⠸⢿⣿⡶⣾⡍⠉⠁⠀⠀⣠⡾⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡴⠋⠀⠀⠀⣸⠁⠀⢠⣾⣿⣯⣕⣿⣯⠖⢉⡴⢋⣼⣽⣵⣯⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      "⠈⢿⣆⡀⠀⢺⣿⡇⠻⣿⣄⣀⣤⡾⠛⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⠎⠀⠀⠀⢠⣼⡇⠀⠀⠀⠻⣯⢛⡵⠚⢁⡴⠊⣠⣾⣿⣿⣿⣿⣇⠀⠀⠀⠀⠀⠀⠀⠀",
      "⠀⠀⠙⠿⣶⣾⣿⣇⠀⢿⣿⠟⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣤⣾⠁⠀⠀⠀⢠⣿⣿⡇⠀⠀⠀⢡⣿⠏⣀⠔⢋⡠⣪⣿⣿⣿⠟⠻⠇⡼⠀⠀⠀⠀⠀⠀⠀⠀",
      "⠀⠀⠀⠀⠀⠈⠉⢻⡄⠈⢳⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣰⣿⣿⠇⠀⠀⣀⣰⣿⣿⣿⠀⠀⠀⠀⣆⣿⡏⢁⣴⣯⡾⠋⣿⣿⡁⠀⠀⠀⠳⡆⠀⠀⠀⠀⠀⠀⠀",
      "⠀⠀⠀⠀⠀⠀⠀⠈⢿⠀⠀⠙⢦⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣴⣾⡿⠋⠀⢀⣠⣶⣿⣯⡿⣿⡇⠀⠀⠀⠠⡽⣷⢞⣽⡿⠋⠀⠀⠘⣿⠿⠂⠀⠀⢸⡇⠀⠀⠀⠀⠀⠀⠀",
      "⠀⠀⠀⠀⠀⠀⠀⠀⠈⢳⡀⠀⢲⣾⣿⠓⠲⢤⣤⣤⠤⠔⣲⠟⠛⠋⠁⢀⣴⣴⡿⣿⣽⣿⣿⣿⣿⡁⠀⠀⠀⢰⣻⡿⠟⠁⠀⠀⠀ ⠀⠈⣧⠀⠀⠀⣼⠇⠀⠀⠀⠀⠀⠀⠀",
      "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⣦⣄⡙⠁⠀⠐⠿⠿⠀⠀⠀⠀⠀⠐⠿⠿⢾⣻⣴⣿⣿⡿⠿⠻⣿⡿⠀⠀⠀⠀⣾⡟⠀⠀⠀⠀⠀⠀ ⠀ ⠘⣇⠀⣼⡿⠀⠀⠀⠀⠀⠀⠀⠀",
      "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠙⢿⣿⣶⣾⣿⣶⣶⣦⣤⣤⣴⣖⣶⣾⡿⠿⠛⢉⣀⣤⣴⣶⣿⡇⠀⠀⠀⢰⡟⠀⠀⠀⠀⠀⠀⠀ ⠀⠀⠀⢹⢰⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠙⠻⠿⢿⣻⣿⣿⣿⠛⣭⣴⣒⣒⣚⣛⣯⡭⠽⠛⠋⣿⡇⠀⠀⢠⡞⠁⠀⠀⠀⠀⠀⠀⠀ ⠀⠀⢀⡿⢠⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠉⠉⠉⠉⠉⠉⠉⠀⠀⠀  ⠀⠀⠀⢻⣷⠀⢀⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀ ⠀⠀⣞⣀⠏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀   ⠀⠸⣿⣀⣮⡷⠀⠀⠀⠀⠀⠀⠀⠀⠀ ⠀⠸⠿⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀  ⢿⣿⣻⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀  ⠘⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
      "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀  ⠘⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
    }

    local buf = vim.api.nvim_create_buf(false, true)

    -- Calculate vertical centering
    local height = vim.api.nvim_get_option_value("lines", {})
    local padding = math.floor((height - #art) / 2)
    local lines = {}
    for _ = 1, padding do table.insert(lines, "") end
    for _, line in ipairs(art) do table.insert(lines, line) end

    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

    -- Set buffer options for a clean look
    vim.api.nvim_set_option_value("bufhidden", "wipe", { buf = buf })
    vim.api.nvim_set_option_value("buftype", "nofile", { buf = buf })
    vim.api.nvim_set_option_value("buflisted", false, { buf = buf })
    vim.api.nvim_set_option_value("swapfile", false, { buf = buf })
    vim.api.nvim_set_option_value("modifiable", false, { buf = buf })

    -- Local window options (more aggressive hiding)
    vim.api.nvim_create_autocmd("BufEnter", {
      buffer = buf,
      callback = function()
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
        vim.opt_local.signcolumn = "no"
        vim.opt_local.statusline = " "
        vim.opt_local.laststatus = 0
        vim.opt_local.cursorline = false
        vim.opt_local.winbar = ""
        vim.opt_local.foldcolumn = "0"
      end,
    })

    vim.api.nvim_set_current_buf(buf)

    -- Keybind to leave dashboard easily
    vim.keymap.set("n", "i", function() vim.cmd("enew") end, { buffer = buf, silent = true })
    vim.keymap.set("n", "e", function() vim.cmd("enew") end, { buffer = buf, silent = true })
    vim.keymap.set("n", "q", function() vim.cmd("q") end, { buffer = buf, silent = true })
  end

  vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
      if vim.fn.argc() == 0 and vim.fn.line2byte("$") == -1 then
        draw_ascii()
      end
    end,
  })
end

return M
