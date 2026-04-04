local luasnip = require('luasnip')

local M = {}

-- Example: load snippets from a Lua file that returns a snippet list
function M.add_snippets(lang, snippet_path)
  local snippets = dofile(snippet_path)
  if snippets then
    luasnip.add_snippets(lang, snippets)
  end
end

function M.setup()
  -- luasnip is already loaded; nothing extra needed
end

return M
