-- Force nvim-treesitter to use the system tree-sitter from Nix
local tree_sitter_cli = vim.fn.exepath('tree-sitter')
if tree_sitter_cli ~= '' then
  require('nvim-treesitter.install').command = tree_sitter_cli
end

require('nvim-treesitter.install').prefer_git = false
require('nvim-treesitter.install').compilers = { "gcc" }

require('nvim-treesitter.configs').setup({
  highlight = {
    enable = true,
  },
  indent = {
    enable = true,
  },
  ensure_installed = {}, -- Leave empty, install manually as needed
  auto_install = false,  -- Disable auto-install on NixOS
})
