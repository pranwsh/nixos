return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  opts = {
    indent = {
      char = "│",
    },
    scope = {
      enabled = true,
      char = "│",
      highlight = { "IblScope" },
      include = {
        node_type = {
          ["*"] = { "*" }
        }
      },
    },
    exclude = {
      filetypes = { "nvim-tree", "help", "terminal" },
    },
  },
}
