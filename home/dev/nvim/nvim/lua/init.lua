-- lua/init.lua
-- ─────────────────────────────────────────────────────────────────────────────
-- Entry point. Loads options, plugins, discovers lang specs, boots core.
-- ─────────────────────────────────────────────────────────────────────────────

require("options")

-- ── Plugins ──────────────────────────────────────────────────────────────────
-- Each file in plugins/ is loaded unconditionally at startup.

local function load_dir(dir, prefix)
  for _, path in ipairs(vim.fn.glob(dir .. "/*.lua", false, true)) do
    local mod = prefix .. "." .. vim.fn.fnamemodify(path, ":t:r")
    local ok, err = pcall(require, mod)
    if not ok then
      vim.notify("[init] failed to load " .. mod .. ": " .. err, vim.log.levels.WARN)
    end
  end
end

load_dir(vim.fn.stdpath("config") .. "/lua/plugins", "plugins")

-- ── Lang spec discovery ───────────────────────────────────────────────────────
-- Each file in langs/ returns a table with any of:
--   lsp  = { servers      = { [server_name] = opts } }
--   lint = { linters_by_ft = { [filetype]   = { "linter", ... } } }

local lsp_servers = {}
local lint_by_ft  = {}

for _, path in ipairs(vim.fn.glob(vim.fn.stdpath("config") .. "/lua/langs/*.lua", false, true)) do
  local mod = "langs." .. vim.fn.fnamemodify(path, ":t:r")
  local ok, spec = pcall(require, mod)
  if not ok then
    vim.notify("[init] failed to load " .. mod .. ": " .. spec, vim.log.levels.WARN)
  else
    if spec.lsp then
      for server, opts in pairs(spec.lsp.servers or {}) do
        lsp_servers[server] = opts
      end
    end
    if spec.lint then
      for ft, linters in pairs(spec.lint.linters_by_ft or {}) do
        lint_by_ft[ft] = linters
      end
    end
  end
end

-- ── Core bootstrap ────────────────────────────────────────────────────────────
-- Order matters: snippets → cmp (needs snippet source) → lsp (needs cmp caps).
local function setup(mod, ...)
  local ok, m = pcall(require, mod)
  if not ok then
    vim.notify("[init] failed to load " .. mod .. ": " .. m, vim.log.levels.ERROR)
    return
  end
  if m.setup then
    local ok2, err = pcall(m.setup, m, ...)
    if not ok2 then
      vim.notify("[init] " .. mod .. ".setup() failed: " .. err, vim.log.levels.ERROR)
    end
  end
end

require("core.snippets").setup()
require("core.cmp").setup()
require("core.lsp").setup(lsp_servers)
require("core.lint").setup(lint_by_ft)
require("core.treesitter").setup()
require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/lua/snippets/" })

-- vim.api.nvim_create_autocmd("User", {
--   pattern  = "VeryLazy",
--   callback = function() require("core.treesitter").setup() end,
-- })
