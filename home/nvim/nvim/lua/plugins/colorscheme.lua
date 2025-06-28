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
        colors.blue      = "#8be9fd"
        colors.blue0     = "#6272a4"
        colors.blue1     = "#8be9fd"
        colors.blue2     = "#ff5555"
        colors.blue5     = "#bd93f9"
        colors.blue6     = "#ff79c6"
        colors.blue7     = "#f8f8f2"
        colors.comment   = "#6272a4"
        colors.cyan      = "#8be9fd"
        colors.dark3     = "#44475a"
        colors.dark5     = "#282a36"
        colors.fg        = "#f8f8f2"
        colors.fg_dark   = "#44475a"
        colors.fg_gutter = "#6272a4"
        colors.green     = "#50fa7b"
        colors.green1    = "#69ff94"
        colors.green2    = "#ff92df"
        colors.magenta   = "#ff79c6"
        colors.magenta2  = "#ff79c6"
        colors.orange    = "#f8f8f2"  -- overridden to white
        colors.purple    = "#bd93f9"
        colors.red       = "#ff5555"
        colors.red1      = "#ff6e6e"
        colors.teal      = "#8be9fd"
      end,
      on_highlights = function(highlights, colors)
        highlights.DiagnosticVirtualTextError = { bg = "NONE" }
        highlights.DiagnosticVirtualTextWarn = { bg = "NONE" }
        highlights.DiagnosticVirtualTextInfo = { bg = "NONE" }
        highlights.DiagnosticVirtualTextHint = { bg = "NONE" }
        highlights.LspInlayHint = { bg = "NONE" }
        highlights.LspInlayHintParameter = { bg = "NONE" }
        highlights.LspInlayHintType = { bg = "NONE" }

        highlights.Keyword = { fg = colors.purple }
        highlights.Statement = { fg = colors.purple }
        highlights.Conditional = { fg = colors.purple }
        highlights.Repeat = { fg = colors.purple }

        highlights.Function = { fg = colors.magenta }
        highlights["@function"] = { fg = colors.magenta }
        highlights["@method"] = { fg = colors.magenta }

        highlights.Identifier = { fg = colors.red }
        highlights["@variable"] = { fg = colors.red }
        highlights["@parameter"] = { fg = colors.magenta }

        highlights.Type = { fg = colors.purple }
        highlights["@type"] = { fg = colors.purple }

        highlights.String = { fg = colors.green }
        highlights.Constant = { fg = colors.red }
        highlights.Number = { fg = colors.red }

        highlights.Operator = { fg = colors.magenta }
        highlights["@punctuation.bracket"] = { fg = colors.purple }
        highlights["@punctuation.delimiter"] = { fg = colors.magenta }

        highlights.TabLine = { bg = "NONE", fg = colors.fg_dark }
        highlights.TabLineFill = { bg = "NONE" }
        highlights.TabLineSel = { bg = "NONE", fg = colors.blue, bold = true }
      end,
    },
  },
}
