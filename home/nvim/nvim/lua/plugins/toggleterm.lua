return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        shade_terminals = false,
        highlights = {
          Normal = {
            guibg = "NONE",
          },
          NormalFloat = {
            link = 'Normal'
          },
          FloatBorder = {
            guifg = "NONE",
            guibg = "NONE",
          },
        },
        float_opts = {
          border = 'none',
        },
      })
    end,
  },
}
