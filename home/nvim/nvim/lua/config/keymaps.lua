-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- Compile & run C from current buffer
map("n", "<leader>rr",
  ":w<CR>:terminal gcc -std=c18 '%' -o '%:r' && ./'%:r'<CR>",
  { desc = "Build & Run C" }
)

-- Compile with debug symbols and launch gdb
map("n", "<leader>rd",
  ":!gcc -g -std=c18 \"%\" -o \"%:r\" && gdb ./%:r<CR>",
  { desc = "Build & Debug C" }
)
