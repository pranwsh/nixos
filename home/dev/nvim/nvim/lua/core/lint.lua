-- core/lint.lua
-- Drives nvim-lint. Linters are wired per-filetype from langs/ specs.

local M = {}

local patched = false

-- checkstyle reports SARIF locations as `file:/path`, but nvim-lint's
-- `for_sarif` parser only recognises `file:///`. It then joins the bogus URI
-- onto the cwd, the resolved buffer never matches the edited file, and every
-- diagnostic is silently dropped. Rewrite the URIs before the real parser.
local function patch_checkstyle()
  if patched then return end
  local ok, cs = pcall(require, "lint.linters.checkstyle")
  if not ok or type(cs.parser) ~= "function" then return end

  local base = cs.parser
  cs.parser = function(out, bufnr, cwd)
    out = out:gsub('"uri":%s*"file:/([^"]*)"', '"uri": "file:///%1"')
    return base(out, bufnr, cwd)
  end

  patched = true
end

function M.setup(linters_by_ft)
  local ok, lint = pcall(require, "lint")
  if not ok then return end

  lint.linters_by_ft = linters_by_ft

  patch_checkstyle()

  -- Run linters on save and when leaving insert mode.
  vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
    callback = function()
      lint.try_lint()
    end,
  })
end

return M
