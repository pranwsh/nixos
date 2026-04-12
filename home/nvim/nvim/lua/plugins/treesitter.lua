require("nvim-treesitter.configs").setup({
  highlight = {
    enable = true,
    disable = { "latex" }, -- Let VimTeX handle it
  },
})
