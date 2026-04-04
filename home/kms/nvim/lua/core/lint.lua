local lint = require('lint')
local linters_by_ft = {}

local M = {}

function M.add_linter(filetype, linter)
  if not linters_by_ft[filetype] then
    linters_by_ft[filetype] = {}
  end
  table.insert(linters_by_ft[filetype], linter)
end

function M.setup()
  lint.linters_by_ft = linters_by_ft
  vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
    callback = function() lint.try_lint() end,
  })
end

return M
