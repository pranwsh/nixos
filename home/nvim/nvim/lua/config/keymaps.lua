-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here



-- Compile C
vim.keymap.set("n", "<leader>rc", function()
  local file = vim.fn.expand("%")
  local file_no_ext = vim.fn.expand("%:r")
  vim.cmd("w") -- Save file first
  vim.cmd(string.format("!gcc -o %s %s", file_no_ext, file))
end, vim.tbl_extend("force", opts, { desc = "Compile C file" }))

-- Run compiled C
vim.keymap.set("n", "<leader>rw", function()
  local file_no_ext = vim.fn.expand("%:r")
  vim.cmd("!" .. file_no_ext)
end, vim.tbl_extend("force", opts, { desc = "Run C program" }))

-- Compile and run C
vim.keymap.set("n", "<leader>rr", function()
  local file = vim.fn.expand("%")
  local file_no_ext = vim.fn.expand("%:r")
  vim.cmd("w") -- Save file first
  vim.cmd(string.format("!gcc -o %s %s && %s", file_no_ext, file, file_no_ext))
end, vim.tbl_extend("force", opts, { desc = "Compile and run C file" }))
