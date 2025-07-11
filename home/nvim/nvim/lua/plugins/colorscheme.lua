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

        -- colors.blue      = "#f0c6c6"
        -- colors.blue0     = "#ca9ee6"
        -- colors.blue1     = "#8be9fd"
        -- colors.blue2     = "#ff5555"
        -- colors.blue5     = "#bd93f9"
        -- colors.blue6     = "#ff79c6"
        -- colors.blue7     = "#f8f8f2"
        -- colors.comment   = "#c6d0f5"
        -- colors.cyan      = "#8be9fd"
        -- colors.dark3     = "#f4dbd6"
        -- colors.dark5     = "#f5bde5"
        -- colors.fg        = "#f8f8f2"
        -- colors.fg_dark   = "#ea999c"
        -- colors.fg_gutter = "#81c8be"
        -- colors.green     = "#ffcccc"
        -- colors.green1    = "#ffcccc"
        -- colors.green2    = "#ff92df"
        -- colors.magenta   = "#ff79c6"
        -- colors.magenta2  = "#ee99a0"
        -- colors.orange    = "#f8f8f2"  -- overridden to white
        -- colors.purple    = "#bd93f9"
        -- colors.red       = "#ff5555"
        -- colors.red1      = "#ff6e6e"
        -- colors.teal      = "#8be9fd"
        -- colors.yellow    = "#c900ff"


colors.blue      = "#9580ff"  -- indigo tint
colors.blue0     = "#6272a4"  -- classic Dracula blue
colors.blue1     = "#9580ff"
colors.blue2     = "#bd93f9"  -- soft purple-indigo
colors.blue5     = "#caa9fa"  -- lighter purple
colors.blue6     = "#d6acff"  -- even lighter violet
colors.blue7     = "#f2eafa"  -- very light magenta background
colors.comment   = "#6e6a86"  -- muted purple/gray
colors.cyan      = "#8be9fd"  -- still useful for cyan highlights
colors.dark3     = "#4d4f68"  -- shadow purple/gray
colors.dark5     = "#34314c"  -- near-black indigo
colors.fg        = "#f8f8f2"  -- Dracula foreground
colors.fg_dark   = "#bd93f9"  -- Dracula purple as dark fg
colors.fg_gutter = "#9580ff"  -- indigo border accent
colors.green     = "#ffb8d1"  -- pastel magenta-pink
colors.green1    = "#ff9ac1"
colors.green2    = "#ff79c6"  -- Dracula pink
colors.magenta   = "#ff79c6"
colors.magenta2  = "#ff92df"
colors.orange    = "#ffb3e4"  -- pinky orange tint
colors.purple    = "#bd93f9"
colors.red       = "#ff5555"
colors.red1      = "#ff6e6e"
colors.teal      = "#8be9fd"
colors.yellow    = "#ffccff"  -- pastel lavender-pink
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

        highlights.Type = { fg = colors.yellow }
        highlights["@type"] = { fg = colors.yellow }

        highlights.String = { fg = colors.green }
        highlights.Constant = { fg = colors.red }
        highlights.Number = { fg = colors.red }

        highlights.Operator = { fg = colors.magenta }
        highlights["@punctuation.bracket"] = { fg = colors.purple }
        highlights["@punctuation.delimiter"] = { fg = colors.magenta }

        highlights.TabLine = { bg = "NONE", fg = colors.fg_dark }
        highlights.TabLineFill = { bg = "NONE" }
        highlights.TabLineSel = { bg = "NONE", fg = colors.blue, bold = true }

        highlights.LspReferenceText = {
          bg = "NONE", -- Remove background highlight
          bold = true, -- Make text bold instead
        }
        highlights.LspReferenceRead = {
          bg = "NONE",
          bold = true,
        }
        highlights.LspReferenceWrite = {
          bg = "NONE",
          bold = true,
        }
      end,
    },
  },
}
