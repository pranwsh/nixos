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
        colors.bg        = c.background or colors.bg
        colors.fg        = c.foreground or colors.fg
        colors.comment   = c.color8 or colors.comment
        colors.fg_gutter = c.color8 or colors.fg_gutter
        colors.fg_dark   = c.color7 or colors.fg_dark
        colors.dark3     = c.color0 or colors.dark3
        colors.dark5     = c.color0 or colors.dark5
        colors.red       = c.color1 or colors.red
        colors.green     = c.color2 or colors.green
        colors.orange    = c.color3 or colors.orange
        colors.blue      = c.color4 or colors.blue
        colors.magenta   = c.color5 or colors.magenta
        colors.cyan      = c.color6 or colors.cyan
        colors.yellow    = c.color15 or colors.yellow
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
        local bg_none = { bg = "NONE" }
        hl.Normal = bg_none
        hl.NormalFloat = bg_none
        hl.NormalNC = bg_none
        hl.SignColumn = bg_none
        hl.LineNr = bg_none
        hl.CursorLineNr = bg_none
        hl.CursorLine = bg_none
        hl.CursorColumn = bg_none
        hl.ColorColumn = bg_none
        hl.Folded = bg_none
        hl.FoldColumn = bg_none
        hl.VertSplit = bg_none
        hl.WinSeparator = bg_none
        hl.StatusLine = bg_none
        hl.StatusLineNC = bg_none
        hl.TabLine = { bg = "NONE", fg = colors.fg_gutter }
        hl.TabLineFill = bg_none
        hl.TabLineSel = { bg = "NONE", fg = colors.fg, bold = true }
        hl.EndOfBuffer = bg_none

        -- Popup/completion menus
        hl.Pmenu = bg_none
        hl.PmenuSel = { bg = "NONE", bold = true }
        hl.PmenuSbar = bg_none
        hl.PmenuThumb = bg_none

        hl.IblIndent = {
          fg = c.color8 or colors.fg_gutter,
          nocombine = true,
        }
        hl.IblScope = {
          fg = c.color4 or colors.blue,
          nocombine = true,
        }

        -- Diagnostics / LSP / semantic tokens (kept as-is)
        hl.DiagnosticVirtualTextError = bg_none
        hl.DiagnosticVirtualTextWarn = bg_none
        hl.DiagnosticVirtualTextInfo = bg_none
        hl.DiagnosticVirtualTextHint = bg_none
        hl.LspInlayHint = bg_none
        hl.LspInlayHintParameter = bg_none
        hl.LspInlayHintType = bg_none
        hl.LspReferenceText = { bg = "NONE", bold = true }
        hl.LspReferenceRead = { bg = "NONE", bold = true }
        hl.LspReferenceWrite = { bg = "NONE", bold = true }
        if c.cursor then
          hl.Cursor = { fg = c.background or "NONE", bg = c.cursor }
        end

        -- Semantic syntax highlighting (kept as-is)
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
