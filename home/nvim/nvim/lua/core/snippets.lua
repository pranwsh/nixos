-- core/snippets.lua
-- Minimal LuaSnip bootstrap. Friendly-snippets are loaded if available.

local M = {}

function M.setup()
  local ok, ls = pcall(require, "luasnip")
  if not ok then return end

  ls.config.set_config({
    history        = true,
    updateevents   = "TextChanged,TextChangedI",
    delete_check_events = "TextChanged",
  })

  -- Load VS Code-style snippets (friendly-snippets, etc.) if the loader exists.
  local loader_ok, loader = pcall(require, "luasnip.loaders.from_vscode")
  if loader_ok then
    loader.lazy_load()
  end
end

return M
