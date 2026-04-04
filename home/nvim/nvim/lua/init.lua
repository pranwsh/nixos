-- ─────────────────────────────────────────────────────────────────────────────
-- lua/init.lua
-- Sets vim options, auto-discovers every langs/*.lua spec, merges them, then
-- hands the unified config to each generic core module.
-- ─────────────────────────────────────────────────────────────────────────────

-- ── Leader ───────────────────────────────────────────────────────────────────
vim.g.mapleader      = " "
vim.g.maplocalleader = "\\"

-- ── Options ──────────────────────────────────────────────────────────────────
local opt = vim.opt

opt.number         = true
opt.relativenumber = true
opt.signcolumn     = "yes"

opt.expandtab  = true
opt.shiftwidth = 2
opt.tabstop    = 2
opt.smartindent = true

opt.wrap        = false
opt.scrolloff   = 8
opt.sidescrolloff = 8

opt.termguicolors = true
opt.cursorline    = true
opt.splitbelow    = true
opt.splitright    = true

opt.ignorecase = true
opt.smartcase  = true
opt.hlsearch   = false
opt.incsearch  = true

opt.updatetime  = 250
opt.timeoutlen  = 300
opt.completeopt = { "menuone", "noselect" }

opt.undofile  = true
opt.swapfile  = false
opt.backup    = false

-- ── Global keymaps ───────────────────────────────────────────────────────────
local map = function(mode, lhs, rhs, desc)
  vim.keymap.set(mode, lhs, rhs, { silent = true, desc = desc })
end

map("n", "<leader>w",  "<cmd>w<CR>",       "Save")
map("n", "<leader>q",  "<cmd>q<CR>",       "Quit")
map("n", "<leader>h",  "<cmd>nohl<CR>",    "Clear search highlight")
map("n", "<C-h>",      "<C-w>h",           "Move to left window")
map("n", "<C-j>",      "<C-w>j",           "Move to lower window")
map("n", "<C-k>",      "<C-w>k",           "Move to upper window")
map("n", "<C-l>",      "<C-w>l",           "Move to right window")
map("v", "<",          "<gv",              "Indent left (keep selection)")
map("v", ">",          ">gv",              "Indent right (keep selection)")
map("n", "[b",         "<cmd>bprev<CR>",   "Prev buffer")
map("n", "]b",         "<cmd>bnext<CR>",   "Next buffer")

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
local lsp_servers    = {}   -- { server_name = opts }
local lint_by_ft     = {}   -- { filetype    = { linters } }

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
require("core.treesitter").setup()
