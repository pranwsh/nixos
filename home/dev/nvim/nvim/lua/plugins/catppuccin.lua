require("catppuccin").setup({
  flavour = "mocha",
  transparent_background = true,

  integrations = {
    cmp = true,
    which_key = true,
  },
      custom_highlights = function(colors)
        return {
          -- ── General float base ───────────────────────────────────────
          NormalFloat = { fg = colors.text, bg = colors.none },
          FloatBorder = { fg = colors.blue, bg = colors.none },

          -- ── nvim-cmp ─────────────────────────────────────────────────
          Pmenu                 = { fg = colors.text,     bg = colors.none },
          PmenuSel              = { fg = colors.mantle,   bg = colors.blue },
          PmenuSbar             = { bg = colors.surface0 },
          PmenuThumb            = { bg = colors.overlay0 },

          CmpNormal             = { bg = colors.none },
          CmpDocumentation      = { bg = colors.none },
          CmpDocumentationBorder = { fg = colors.blue,   bg = colors.none },

          CmpItemAbbr           = { fg = colors.text },
          CmpItemAbbrMatch      = { fg = colors.blue,    style = { "bold" } },
          CmpItemAbbrMatchFuzzy = { fg = colors.sky,     style = { "bold" } },
          CmpItemMenu           = { fg = colors.subtext0 },

          -- ── which-key ────────────────────────────────────────────────
          WhichKeyNormal    = { bg = colors.none },
          WhichKeyFloat     = { bg = colors.none },
          WhichKeyBorder    = { fg = colors.blue,    bg = colors.none },
          WhichKeyTitle     = { fg = colors.blue,    bg = colors.none, style = { "bold" } },
          WhichKey          = { fg = colors.lavender },
          WhichKeyGroup     = { fg = colors.blue,    style = { "bold" } },
          WhichKeyDesc      = { fg = colors.text },
          WhichKeySeparator = { fg = colors.overlay0 },
          WhichKeyValue     = { fg = colors.subtext0 },
        }
      end,
    })

vim.cmd.colorscheme("catppuccin")
