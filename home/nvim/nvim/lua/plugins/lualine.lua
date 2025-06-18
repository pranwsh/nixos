return {
  "nvim-lualine/lualine.nvim",
  opts = function(_, opts)
    opts.options = vim.tbl_deep_extend("force", opts.options or {}, {
      theme = {
        normal = { c = { fg = "#ffffff", bg = nil }, a = { bg = nil }, b = { bg = nil } },
        insert = { a = { bg = nil } },
        visual = { a = { bg = nil } },
        replace = { a = { bg = nil } },
        inactive = { c = { fg = "#ffffff", bg = nil }, a = { bg = nil }, b = { bg = nil } },
      },
    })
  end,
}
