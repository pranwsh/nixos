-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- C file compile and run keymaps
vim.keymap.set("n", "<leader>cc", function()
  local file = vim.fn.expand("%:p")
  local file_no_ext = vim.fn.expand("%:p:r")
  local cmd = string.format("gcc -o %s %s", file_no_ext, file)
  vim.cmd("!" .. cmd)
end, { desc = "Compile C file" })

vim.keymap.set("n", "<leader>cr", function()
  local file_no_ext = vim.fn.expand("%:p:r")
  vim.cmd("!" .. file_no_ext)
end, { desc = "Run compiled C program" })

vim.keymap.set("n", "<leader>cb", function()
  local file = vim.fn.expand("%:p")
  local file_no_ext = vim.fn.expand("%:p:r")
  local compile_cmd = string.format("gcc -o %s %s", file_no_ext, file)
  vim.cmd("!" .. compile_cmd .. " && " .. file_no_ext)
end, { desc = "Compile and run C file" })

-- Alternative using terminal
vim.keymap.set("n", "<leader>ct", function()
  local file = vim.fn.expand("%:p")
  local file_no_ext = vim.fn.expand("%:p:r") 
  local cmd = string.format("gcc -o %s %s && %s", file_no_ext, file, file_no_ext)
  vim.cmd("terminal " .. cmd)
end, { desc = "Compile and run C file in terminal" })

-- With debug flags
vim.keymap.set("n", "<leader>cd", function()
  local file = vim.fn.expand("%:p")
  local file_no_ext = vim.fn.expand("%:p:r")
  local cmd = string.format("gcc -g -Wall -o %s %s && %s", file_no_ext, file, file_no_ext)
  vim.cmd("!" .. cmd)
end, { desc = "Compile C file with debug flags and run" })
