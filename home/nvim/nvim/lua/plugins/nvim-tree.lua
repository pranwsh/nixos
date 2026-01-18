return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("nvim-tree").setup({
      view = {
        width = 26,          
        side = "left",
        signcolumn = "no",
      },
      renderer = {
        indent_markers = {
          enable = true,
        },
        icons = {
          show = {
            file = true,
            folder = true,
            folder_arrow = false,
          },
        },
      },
      filters = {
        dotfiles = false,
      },
    })
  end,
}
