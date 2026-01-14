return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = false,
    priority = 1000,
    config = function()
      require("nvim-treesitter").setup({
        ensure_installed = "all",  -- Install all maintained parsers
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },
}
