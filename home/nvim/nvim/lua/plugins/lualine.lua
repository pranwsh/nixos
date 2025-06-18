return {
  "nvim-lualine/lualine.nvim",
  opts = function(_, opts)
    opts.options = opts.options or {}
    opts.options.theme = opts.options.theme or "auto"
    opts.sections = opts.sections or {}

    -- Override highlight groups for transparency
    local transparent = { bg = "none" }
    opts.options.component_separators = { left = "", right = "" }
    opts.options.section_separators = { left = "", right = "" }

    -- Apply transparency to all Lualine sections
    opts.sections = {
      lualine_a = { { "mode", color = transparent } },
      lualine_b = { { "branch", color = transparent }, { "diff", color = transparent } },
      lualine_c = { { "filename", color = transparent } },
      lualine_x = { { "encoding", color = transparent }, { "fileformat", color = transparent }, { "filetype", color = transparent } },
      lualine_y = { { "progress", color = transparent } },
      lualine_z = { { "location", color = transparent } },
    }
  end,
}
