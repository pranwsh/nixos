return {
  "nvim-lualine/lualine.nvim",
  opts = function(_, opts)
    -- Create transparent theme
    local transparent_theme = {
      normal = {
        a = { bg = "NONE", fg = "#ffffff", gui = "bold" },
        b = { bg = "NONE", fg = "#ffffff" },
        c = { bg = "NONE", fg = "#ffffff" },
      },
      insert = {
        a = { bg = "NONE", fg = "#ffffff", gui = "bold" },
        b = { bg = "NONE", fg = "#ffffff" },
        c = { bg = "NONE", fg = "#ffffff" },
      },
      visual = {
        a = { bg = "NONE", fg = "#ffffff", gui = "bold" },
        b = { bg = "NONE", fg = "#ffffff" },
        c = { bg = "NONE", fg = "#ffffff" },
      },
      replace = {
        a = { bg = "NONE", fg = "#ffffff", gui = "bold" },
        b = { bg = "NONE", fg = "#ffffff" },
        c = { bg = "NONE", fg = "#ffffff" },
      },
      command = {
        a = { bg = "NONE", fg = "#ffffff", gui = "bold" },
        b = { bg = "NONE", fg = "#ffffff" },
        c = { bg = "NONE", fg = "#ffffff" },
      },
      inactive = {
        a = { bg = "NONE", fg = "#666666" },
        b = { bg = "NONE", fg = "#666666" },
        c = { bg = "NONE", fg = "#666666" },
      },
    }

    -- Apply transparent theme
    opts.options = opts.options or {}
    opts.options.theme = transparent_theme
    
    -- Remove section separators for cleaner look
    opts.options.section_separators = { left = "", right = "" }
    opts.options.component_separators = { left = "", right = "" }
    
    return opts
  end,
}
