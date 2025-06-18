-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

require("lazy").setup({
  -- your plugins here
}, {
  lockfile = vim.fn.stdpath("data") .. "/lazy-lock.json",
})
