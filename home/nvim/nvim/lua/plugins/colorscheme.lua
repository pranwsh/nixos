return {
  {
    "folke/tokyonight.nvim",
    opts = {
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
      on_colors = function(colors)
        colors.blue      = "#ff8a6a"
        colors.blue0     = "#c1246b"
        colors.blue1     = "#ff8a6a"
        colors.blue2     = "#fd4c55"
        colors.blue5     = "#ff6f4b"
        colors.blue6     = "#e13661"
        colors.blue7     = "#ffbbbb"
        colors.comment   = "#fd4c55"
        colors.cyan      = "#f13c65"
        colors.dark3     = "#ec7c94"
        colors.dark5     = "#e66b8f"
        colors.fg        = "#c1246b"
        colors.fg_dark   = "#d98bb2"
        colors.fg_gutter = "#cb7da6"
        colors.green     = "#c47da6"
        colors.green1    = "#be86b2"
        colors.green2    = "#b890c2"
        colors.magenta   = "#b397cc"
        colors.magenta2  = "#aa9cd1"
        colors.orange    = "#a8a1d6"
        colors.purple    = "#a2a9da"
        colors.red       = "#f6869f"
        colors.red1      = "#FF4C4C"
        colors.teal      = "#FFB6C6"
        end,
        on_highlights = function(highlights, colors)
          -- Keywords and statements
          highlights.Keyword = { fg = colors.purple }
          highlights.Statement = { fg = colors.purple }
          highlights.Conditional = { fg = colors.purple }
          highlights.Repeat = { fg = colors.purple }
          -- Functions
          highlights.Function = { fg = colors.orange }
          highlights["@function"] = { fg = colors.orange }
          highlights["@method"] = { fg = colors.orange }
          -- Variables and identifiers
          highlights.Identifier = { fg = colors.red }
          highlights["@variable"] = { fg = colors.red }
          highlights["@parameter"] = { fg = colors.magenta }
          -- Types
          highlights.Type = { fg = colors.purple }
          highlights["@type"] = { fg = colors.purple }
          -- Strings and constants
          highlights.String = { fg = colors.orange }
          highlights.Constant = { fg = colors.red }
          highlights.Number = { fg = colors.red }
          -- Operators and punctuation
          highlights.Operator = { fg = colors.magenta }
          highlights["@punctuation.bracket"] = { fg = colors.purple }
          highlights["@punctuation.delimiter"] = { fg = colors.orange }
          
          -- Make tabs transparent
          highlights.TabLine = { bg = "NONE", fg = colors.fg_dark }
          highlights.TabLineFill = { bg = "NONE" }
          highlights.TabLineSel = { bg = "NONE", fg = colors.blue, bold = true }
        end,
    },
  },
}
