-- ─────────────────────────────────────────────────────────────────────────────
-- core/treesitter.lua
-- Treesitter configuration.  Parsers are installed by Nix (via
-- nvim-treesitter.withPlugins in default.nix), so ensure_installed = {}
-- and auto_install = false.  Add parsers in default.nix, not here.
-- ─────────────────────────────────────────────────────────────────────────────

local M = {}

function M.setup()
  require("nvim-treesitter.configs").setup({
    -- Parsers come from Nix — do NOT let treesitter try to compile any
    ensure_installed = {},
    auto_install     = false,
    sync_install     = false,

    highlight = {
      enable  = true,
      -- Disable vim regex highlighting for filetypes treesitter handles well
      additional_vim_regex_highlighting = false,
    },

    indent = {
      enable = true,
    },

    incremental_selection = {
      enable  = true,
      keymaps = {
        init_selection    = "<C-space>",
        node_incremental  = "<C-space>",
        scope_incremental = "<C-s>",
        node_decremental  = "<M-space>",
      },
    },
  })

  -- ── Folding via treesitter (optional, off by default) ─────────────────
  -- Uncomment to enable treesitter-based folding:
  -- vim.opt.foldmethod = "expr"
  -- vim.opt.foldexpr   = "nvim_treesitter#foldexpr()"
  -- vim.opt.foldenable = false   -- open all folds on start
end

return M
