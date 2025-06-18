-- ~/.config/nvim/lua/plugins/tokyonight.lua
return {
  "folke/tokyonight.nvim",
  opts = {
    transparent = true,
    styles = {
      sidebars = "transparent",
      floats = "transparent",
    },
    on_highlights = function(highlights, colors)
      -- Additional transparency overrides
      highlights.Normal = { bg = "NONE" }
      highlights.NormalFloat = { bg = "NONE" }
      highlights.FloatBorder = { bg = "NONE" }
      highlights.Pmenu = { bg = "NONE" }
      highlights.PmenuSel = { bg = colors.bg_highlight }
      highlights.PmenuSbar = { bg = "NONE" }
      highlights.PmenuThumb = { bg = colors.fg_gutter }
      highlights.StatusLine = { bg = "NONE" }
      highlights.StatusLineNC = { bg = "NONE" }
      highlights.TabLine = { bg = "NONE" }
      highlights.TabLineFill = { bg = "NONE" }
      highlights.TabLineSel = { bg = "NONE" }
      highlights.WinBar = { bg = "NONE" }
      highlights.WinBarNC = { bg = "NONE" }
      highlights.SignColumn = { bg = "NONE" }
      highlights.FoldColumn = { bg = "NONE" }
      highlights.LineNr = { bg = "NONE" }
      highlights.CursorLineNr = { bg = "NONE" }
      highlights.EndOfBuffer = { bg = "NONE" }
      
      -- Telescope transparency
      highlights.TelescopeNormal = { bg = "NONE" }
      highlights.TelescopeBorder = { bg = "NONE" }
      highlights.TelescopePromptNormal = { bg = "NONE" }
      highlights.TelescopePromptBorder = { bg = "NONE" }
      highlights.TelescopeResultsNormal = { bg = "NONE" }
      highlights.TelescopeResultsBorder = { bg = "NONE" }
      highlights.TelescopePreviewNormal = { bg = "NONE" }
      highlights.TelescopePreviewBorder = { bg = "NONE" }
      
      -- Neo-tree transparency
      highlights.NeoTreeNormal = { bg = "NONE" }
      highlights.NeoTreeNormalNC = { bg = "NONE" }
      highlights.NeoTreeEndOfBuffer = { bg = "NONE" }
      
      -- Which-key transparency
      highlights.WhichKeyFloat = { bg = "NONE" }
      
      -- Notify transparency
      highlights.NotifyBackground = { bg = "NONE" }
      
      -- Mason transparency
      highlights.MasonNormal = { bg = "NONE" }
      
      -- Lazy transparency
      highlights.LazyNormal = { bg = "NONE" }
    end,
  },
}
