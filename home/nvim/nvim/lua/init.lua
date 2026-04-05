-- lua/init.lua
-- ─────────────────────────────────────────────────────────────────────────────
-- Main Init File
-- Loads options/keymaps, auto-discovers lang specs, then bootstraps core modules.
-- ─────────────────────────────────────────────────────────────────────────────

-- ── Load Options & Keymaps ───────────────────────────────────────────────────
require("options")

-- ── Auto-discover lang specs ─────────────────────────────────────────────────
-- Each file in langs/ returns a table of the shape:
--   {
--     lsp  = { servers = { <server_name> = <lspconfig_opts> } },
--     lint = { linters_by_ft = { <filetype> = { "<linter>", ... } } },
--   }
-- Sections are optional — a lang file may omit any key it doesn't need.

local langs_dir = vim.fn.stdpath("config") .. "/lua/langs"
local lang_files = vim.fn.glob(langs_dir .. "/*.lua", false, true)

-- Merged containers
local lsp_servers = {}   -- { server_name = opts }
local lint_by_ft  = {}   -- { filetype    = { linters } }

for _, path in ipairs(lang_files) do
  local mod_name = "langs." .. vim.fn.fnamemodify(path, ":t:r")
  local ok, spec = pcall(require, mod_name)
  if not ok then
    vim.notify("[init] failed to load " .. mod_name .. ": " .. spec, vim.log.levels.WARN)
  else
    -- LSP
    if spec.lsp and spec.lsp.servers then
      for server, opts in pairs(spec.lsp.servers) do
        lsp_servers[server] = opts
      end
    end
    -- Lint
    if spec.lint and spec.lint.linters_by_ft then
      for ft, linters in pairs(spec.lint.linters_by_ft) do
        lint_by_ft[ft] = linters
      end
    end
  end
end

-- ── Bootstrap core modules ───────────────────────────────────────────────────
-- Order matters: snippets → cmp → lsp (cmp capabilities needed for lsp)
require("core.snippets").setup()
require("core.cmp").setup()
require("core.lsp").setup(lsp_servers)
require("core.lint").setup(lint_by_ft)

vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    require("core.treesitter").setup()
  end,
})
