local function load_nix_colors()
  local path = vim.fn.stdpath("config") .. "/nix-colors.json"

  local ok, lines = pcall(vim.fn.readfile, path)
  if not ok or not lines or #lines == 0 then
    return nil
  end

  local json = table.concat(lines, "\n")
  local decode = (vim.json and vim.json.decode) or vim.fn.json_decode
  local ok2, data = pcall(decode, json)
  if not ok2 then
    return nil
  end

  return data
end

local c = load_nix_colors() or {}

return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },

      on_colors = function(colors)
        -- base
        colors.bg        = c.background or colors.bg
        colors.fg        = c.foreground or colors.fg
        colors.comment   = c.color8 or colors.comment

        -- gutters / UI darks
        colors.fg_gutter = c.color8 or colors.fg_gutter
        colors.fg_dark   = c.color7 or colors.fg_dark
        colors.dark3     = c.color0 or colors.dark3
        colors.dark5     = c.color0 or colors.dark5

        -- core accents (map your 16-color palette into tokyonight names)
        colors.red       = c.color1 or colors.red
        colors.green     = c.color2 or colors.green
        colors.orange    = c.color3 or colors.orange
        colors.blue      = c.color4 or colors.blue
        colors.magenta   = c.color5 or colors.magenta
        colors.cyan      = c.color6 or colors.cyan
        colors.yellow    = c.color15 or colors.yellow

        -- optional extra keys that some configs reference
        colors.blue0     = c.color0 or colors.blue0
        colors.blue1     = c.color4 or colors.blue1
        colors.blue2     = c.color12 or colors.blue2
        colors.blue5     = c.color13 or colors.blue5
        colors.blue6     = c.color14 or colors.blue6
        colors.blue7     = c.color15 or colors.blue7

        colors.green1    = c.color10 or colors.green1
        colors.green2    = c.color2 or colors.green2

        colors.magenta2  = c.color13 or colors.magenta2

        colors.red1      = c.color9 or colors.red1
        colors.teal      = c.color6 or colors.teal
      end,

      on_highlights = function(highlights, colors)
        -- keep your "no bg blocks" choices
        highlights.DiagnosticVirtualTextError = { bg = "NONE" }
        highlights.DiagnosticVirtualTextWarn  = { bg = "NONE" }
        highlights.DiagnosticVirtualTextInfo  = { bg = "NONE" }
        highlights.DiagnosticVirtualTextHint  = { bg = "NONE" }

        highlights.LspInlayHint               = { bg = "NONE" }
        highlights.LspInlayHintParameter      = { bg = "NONE" }
        highlights.LspInlayHintType           = { bg = "NONE" }

        -- cursor color from nix (if present)
        if c.cursor then
          highlights.Cursor = { fg = c.background or "NONE", bg = c.cursor }
        end

        -- semantic mapping (uses the tokyonight color table we just patched)
        highlights.Keyword                   = { fg = colors.magenta }
        highlights.Statement                 = { fg = colors.magenta }
        highlights.Conditional               = { fg = colors.magenta }
        highlights.Repeat                    = { fg = colors.magenta }

        highlights.Function                  = { fg = colors.blue }
        highlights["@function"]              = { fg = colors.blue }
        highlights["@method"]                = { fg = colors.blue }

        highlights.Identifier                = { fg = colors.cyan }
        highlights["@variable"]              = { fg = colors.cyan }
        highlights["@parameter"]             = { fg = colors.yellow }

        highlights.Type                      = { fg = colors.yellow }
        highlights["@type"]                  = { fg = colors.yellow }

        highlights.String                    = { fg = colors.green }
        highlights.Constant                  = { fg = colors.orange }
        highlights.Number                    = { fg = colors.orange }

        highlights.Operator                  = { fg = colors.magenta }
        highlights["@punctuation.bracket"]   = { fg = colors.magenta }
        highlights["@punctuation.delimiter"] = { fg = colors.cyan }

        highlights.TabLine                   = { bg = "NONE", fg = colors.fg_gutter }
        highlights.TabLineFill               = { bg = "NONE" }
        highlights.TabLineSel                = { bg = "NONE", fg = colors.fg, bold = true }

        highlights.LspReferenceText          = { bg = "NONE", bold = true }
        highlights.LspReferenceRead          = { bg = "NONE", bold = true }
        highlights.LspReferenceWrite         = { bg = "NONE", bold = true }
      end,
    },
  },
}
