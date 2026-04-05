-- lua/options/init.lua
-- ─────────────────────────────────────────────────────────────────────────────
-- Vim Options & Global Keymaps
-- ─────────────────────────────────────────────────────────────────────────────
-- ── Leader ───────────────────────────────────────────────────────────────────
vim.g.mapleader      = " "
vim.g.maplocalleader = ","

-- ── Options ──────────────────────────────────────────────────────────────────
local opt = vim.opt

opt.number          = true
opt.relativenumber  = true
opt.signcolumn      = "yes"

opt.expandtab       = true
opt.shiftwidth      = 2
opt.tabstop         = 2
opt.smartindent     = true

opt.wrap            = false
opt.scrolloff       = 8
opt.sidescrolloff   = 8

opt.termguicolors   = true
opt.cursorline      = true
opt.splitbelow      = true
opt.splitright      = true

opt.ignorecase      = true
opt.smartcase       = true
opt.hlsearch        = false
opt.incsearch       = true

opt.updatetime      = 250
opt.timeoutlen      = 300
opt.completeopt     = { "menuone", "noselect" }

opt.undofile        = true
opt.swapfile        = false
opt.backup          = false


-- Remove current line highlight
opt.cursorline = false

-- Hide statusline completely
opt.laststatus = 0

-- Remove empty line indicators (~)
opt.fillchars:append({ eob = " " })

-- clipboard
opt.clipboard = "unnamedplus"

wo.numberwidth = 2



-- ── Global Keymaps ───────────────────────────────────────────────────────────
local map = function(mode, lhs, rhs, desc)
  vim.keymap.set(mode, lhs, rhs, { silent = true, desc = desc })
end

map("n", "<leader>w", "<cmd>w<CR>",       "Save")
map("n", "<leader>q", "<cmd>q<CR>",       "Quit")
map("n", "<leader>h", "<cmd>nohl<CR>",    "Clear search highlight")
map("n", "<C-h>",     "<C-w>h",           "Move to left window")
map("n", "<C-j>",     "<C-w>j",           "Move to lower window")
map("n", "<C-k>",     "<C-w>k",           "Move to upper window")
map("n", "<C-l>",     "<C-w>l",           "Move to right window")
map("v", "<",         "<gv",              "Indent left (keep selection)")
map("v", ">",         ">gv",              "Indent right (keep selection)")
map("n", "[b",        "<cmd>bprev<CR>",   "Prev buffer")
map("n", "]b",        "<cmd>bnext<CR>",   "Next buffer")
