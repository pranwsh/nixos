-- lua/plugins/colorscheme.lua
return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    -- Load Nix colors from JSON file
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

    require("tokyonight").setup({
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },

      on_colors = function(colors)
        if not c then return end

        -- Remap tokyonight's color palette to nix-colors
        colors.bg        = c.background or colors.bg
        colors.fg        = c.foreground or colors.fg
        colors.comment   = c.color8 or colors.comment

        -- Gutters / UI darks
        colors.fg_gutter = c.color8 or colors.fg_gutter
        colors.fg_dark   = c.color7 or colors.fg_dark
        colors.dark3     = c.color0 or colors.dark3
        colors.dark5     = c.color0 or colors.dark5

        -- Core accents (map 16-color palette to tokyonight names)
        colors.red       = c.color1 or colors.red
        colors.green     = c.color2 or colors.green
        colors.orange    = c.color3 or colors.orange
        colors.blue      = c.color4 or colors.blue
        colors.magenta   = c.color5 or colors.magenta
        colors.cyan      = c.color6 or colors.cyan
        colors.yellow    = c.color15 or colors.yellow

        -- Extended color variants
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

      on_highlights = function(hl, colors)
        -- Make ALL backgrounds transparent
        hl.Normal = { bg = "NONE" }
        hl.NormalFloat = { bg = "NONE" }
        hl.NormalNC = { bg = "NONE" }
        hl.SignColumn = { bg = "NONE" }
        hl.LineNr = { bg = "NONE" }
        hl.CursorLineNr = { bg = "NONE" }
        hl.CursorLine = { bg = "NONE" }
        hl.CursorColumn = { bg = "NONE" }
        hl.ColorColumn = { bg = "NONE" }
        hl.Folded = { bg = "NONE" }
        hl.FoldColumn = { bg = "NONE" }
        hl.VertSplit = { bg = "NONE" }
        hl.WinSeparator = { bg = "NONE" }
        hl.StatusLine = { bg = "NONE" }
        hl.StatusLineNC = { bg = "NONE" }
        hl.TabLine = { bg = "NONE", fg = colors.fg_gutter }
        hl.TabLineFill = { bg = "NONE" }
        hl.TabLineSel = { bg = "NONE", fg = colors.fg, bold = true }
        hl.EndOfBuffer = { bg = "NONE" }
        
        -- Popup/completion menus
        hl.Pmenu = { bg = "NONE" }
        hl.PmenuSel = { bg = "NONE", bold = true }
        hl.PmenuSbar = { bg = "NONE" }
        hl.PmenuThumb = { bg = "NONE" }
        
        -- Diagnostics - no background blocks
        hl.DiagnosticVirtualTextError = { bg = "NONE" }
        hl.DiagnosticVirtualTextWarn = { bg = "NONE" }
        hl.DiagnosticVirtualTextInfo = { bg = "NONE" }
        hl.DiagnosticVirtualTextHint = { bg = "NONE" }

        -- LSP inlay hints
        hl.LspInlayHint = { bg = "NONE" }
        hl.LspInlayHintParameter = { bg = "NONE" }
        hl.LspInlayHintType = { bg = "NONE" }
        
        -- LSP references
        hl.LspReferenceText = { bg = "NONE", bold = true }
        hl.LspReferenceRead = { bg = "NONE", bold = true }
        hl.LspReferenceWrite = { bg = "NONE", bold = true }

        -- Cursor color from nix
        if c.cursor then
          hl.Cursor = { fg = c.background or "NONE", bg = c.cursor }
        end

        -- Semantic syntax highlighting (uses remapped colors from on_colors)
        hl.Keyword = { fg = colors.magenta }
        hl.Statement = { fg = colors.magenta }
        hl.Conditional = { fg = colors.magenta }
        hl.Repeat = { fg = colors.magenta }
        hl.Operator = { fg = colors.magenta }

        hl.Function = { fg = colors.blue }
        hl["@function"] = { fg = colors.blue }
        hl["@function.call"] = { fg = colors.blue }
        hl["@method"] = { fg = colors.blue }
        hl["@method.call"] = { fg = colors.blue }

        hl.Identifier = { fg = colors.cyan }
        hl["@variable"] = { fg = colors.cyan }
        hl["@variable.member"] = { fg = colors.cyan }
        hl["@property"] = { fg = colors.cyan }
        hl["@field"] = { fg = colors.cyan }
        
        hl["@parameter"] = { fg = colors.yellow }
        hl["@variable.parameter"] = { fg = colors.yellow }

        hl.Type = { fg = colors.yellow }
        hl["@type"] = { fg = colors.yellow }
        hl["@type.builtin"] = { fg = colors.yellow }

        hl.String = { fg = colors.green }
        hl["@string"] = { fg = colors.green }
        
        hl.Constant = { fg = colors.orange }
        hl.Number = { fg = colors.orange }
        hl["@number"] = { fg = colors.orange }
        hl["@constant"] = { fg = colors.orange }

        hl["@punctuation.bracket"] = { fg = colors.magenta }
        hl["@punctuation.delimiter"] = { fg = colors.cyan }

        -- LSP semantic tokens
        hl["@lsp.type.property"] = { fg = colors.cyan }
        hl["@lsp.type.variable"] = { fg = colors.cyan }
        hl["@lsp.type.parameter"] = { fg = colors.yellow }
        hl["@lsp.type.function"] = { fg = colors.blue }
        hl["@lsp.type.method"] = { fg = colors.blue }
        hl["@lsp.type.type"] = { fg = colors.yellow }
        hl["@lsp.type.class"] = { fg = colors.yellow }
      end,
    })

    -- Apply colorscheme
    vim.cmd.colorscheme("tokyonight")
  end,
}
