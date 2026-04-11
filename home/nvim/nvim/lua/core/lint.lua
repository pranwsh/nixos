-- core/lint.lua
-- Drives nvim-lint. Linters are wired per-filetype from langs/ specs.

local M = {}

function M.setup(linters_by_ft)
  local ok, lint = pcall(require, "lint")
  if not ok then return end

  lint.linters_by_ft = linters_by_ft

  -- Run linters on save and when leaving insert mode.
  vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
    callback = function()
      lint.try_lint()
    end,
  })
end

return M
