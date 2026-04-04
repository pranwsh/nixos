-- ─────────────────────────────────────────────────────────────────────────────
-- core/snippets.lua
-- Initialises LuaSnip and loads the VSCode-format snippet collection
-- provided by friendly-snippets (installed via Nix).
-- ─────────────────────────────────────────────────────────────────────────────

local M = {}

function M.setup()
  local luasnip = require("luasnip")

  luasnip.config.set_config({
    history    = true,               -- jump back into exited snippets
    updateevents = "TextChanged,TextChangedI",
    enable_autosnippets = false,
    ext_opts = {
      [require("luasnip.util.types").choiceNode] = {
        active = { virt_text = { { "●", "GruvboxOrange" } } },
      },
    },
  })

  -- Load all VSCode-style snippets from runtimepath
  -- (friendly-snippets is on runtimepath because Nix added it to start packages)
  require("luasnip.loaders.from_vscode").lazy_load()

  -- Also pick up any hand-written snippets placed in ~/.config/nvim/snippets/
  require("luasnip.loaders.from_vscode").lazy_load({
    paths = { vim.fn.stdpath("config") .. "/snippets" },
  })

  -- ── Useful snippet keymaps ─────────────────────────────────────────────
  -- (Tab / S-Tab for jumping are handled inside core/cmp.lua)
  vim.keymap.set({ "i", "s" }, "<C-l>", function()
    if luasnip.choice_active() then luasnip.change_choice(1) end
  end, { silent = true, desc = "LuaSnip: cycle choice" })
end

return M
