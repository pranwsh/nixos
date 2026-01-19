require('nvim-treesitter.configs').setup({
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "cpp", "nix", "python", "bash" },
  
  auto_install = true,
  
  highlight = {
    enable = true,
  },
  indent = {
    enable = true,
  },
})
