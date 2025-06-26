-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.cursorline = false
vim.o.laststatus = 0

vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", { bg = "NONE" })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn", { bg = "NONE" })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextInfo", { bg = "NONE" })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextHint", { bg = "NONE" })
