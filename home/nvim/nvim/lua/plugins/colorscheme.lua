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

        -- colors.blue      = "#F4A8C1"  -- pastel pinkish rose
        -- colors.blue0     = "#E49EC2"  -- softer pink
        -- colors.blue1     = "#FFD1DC"  -- baby pink
        -- colors.blue2     = "#F8BBD0"  -- cotton candy pink
        -- colors.blue5     = "#FFB3C1"  -- cherry blossom
        -- colors.blue6     = "#E0A3C2"  -- mauve-ish pink
        -- colors.blue7     = "#D895C2"  -- dusty pink
        -- colors.comment   = "#D8BFD8"  -- thistle (soft purple)
        -- colors.cyan      = "#FFCCE7"  -- pastel rose
        -- colors.dark3     = "#A98ABF"  -- light indigo
        -- colors.dark5     = "#BAA0D0"  -- soft purple
        -- colors.fg        = "#FFF0D9"  -- pastel cream
        -- colors.fg_dark   = "#F8D8A8"  -- butter yellow
        -- colors.fg_gutter = "#DDA0DD"  -- plum
        -- colors.green     = "#FFCCAA"  -- soft peach (used instead of green)
        -- colors.green1    = "#FFDAB9"  -- peach puff
        -- colors.green2    = "#FFE4B5"  -- moccasin
        -- colors.magenta   = "#FFA6C9"  -- carnation pink
        -- colors.magenta2  = "#FF99CC"  -- light pink
        -- colors.orange    = "#FFCBA4"  -- apricot
        -- colors.purple    = "#CBAACB"  -- light lavender
        -- colors.red       = "#FF8C94"  -- pastel red
        -- colors.red1      = "#FF6F61"  -- coral
        -- colors.teal      = "#F7CACA"  -- pale pink (warm tone)

        colors.blue      = "#FF80A5"
        colors.blue0     = "#F76DA6"
        colors.blue1     = "#FFC2D6"
        colors.blue2     = "#FF99BB"
        colors.blue5     = "#FF99AD"
        colors.blue6     = "#EA70A8"
        colors.blue7     = "#D95CA4"
        colors.comment   = "#E6B0E6"
        colors.cyan      = "#FFB8DE"
        colors.dark3     = "#A266CC"
        colors.dark5     = "#B07ADD"
        colors.fg        = "#FFF1C2"
        colors.fg_dark   = "#FFD488"
        colors.fg_gutter = "#E090E0"
        colors.green     = "#FFB86C"
        colors.green1    = "#FFC285"
        colors.green2    = "#FFCD8F"
        colors.magenta   = "#FF78B4"
        colors.magenta2  = "#FF66AA"
        colors.orange    = "#FFB273"
        colors.purple    = "#D291D2"
        colors.red       = "#FF5E6F"
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
        end,
    },
  },
}
