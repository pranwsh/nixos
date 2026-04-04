local ts = require('nvim-treesitter.configs')
local parsers = {}

local M = {}

function M.add_parser(lang)
  parsers[lang] = true
end

function M.setup()
  ts.setup({
    ensure_installed = vim.tbl_keys(parsers),
    highlight = { enable = true },
    indent = { enable = true },
  })
end

return M
