-- ─────────────────────────────────────────────────────────────────────────────
-- core/lint.lua
-- Wires nvim-lint with the linters_by_ft table merged from all langs/*.lua.
-- Nothing language-specific lives here.
-- ─────────────────────────────────────────────────────────────────────────────

local M = {}

function M.setup(linters_by_ft)
  local lint = require("lint")

  lint.linters_by_ft = linters_by_ft

  -- ── Trigger linting ───────────────────────────────────────────────────
  -- BufWritePost  → after saving
  -- BufReadPost   → after opening / reloading a file
  -- InsertLeave   → when leaving insert mode
  local group = vim.api.nvim_create_augroup("UserLint", { clear = true })

  vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
    group    = group,
    callback = function()
      -- Only lint if a linter exists for the current filetype
      local ft = vim.bo.filetype
      if ft ~= "" and lint.linters_by_ft[ft] then
        lint.try_lint()
      end
    end,
  })

  -- Manual trigger
  vim.keymap.set("n", "<leader>ll", function()
    lint.try_lint()
  end, { silent = true, desc = "Run linter" })
end

return M
