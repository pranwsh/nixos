return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  opts = {
    indent = {
      char = "│",
    },
    scope = {
      enabled = true,   -- shows scope lines for braces
      show_start = false,
      show_end = false,
    },
    exclude = {
      filetypes = {
        "help",
        "nvim-tree",
        "terminal",
      },
    },
  },
}
