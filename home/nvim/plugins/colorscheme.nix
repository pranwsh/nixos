{
  config,
  lib,
  walNix,
  ...
}: let
  c = (import "${walNix}/colors.nix").colorscheme;
  useWal = true; # set to false for default catppuccin mocha
in {
  programs.nvf.settings = {
    vim = {
      theme = {
        enable = true;
        name = "catppuccin";
        style =
          if useWal
          then "frappe"
          else "mocha";
        transparent = true;
      };
      visuals = {
        nvim-web-devicons.enable = true;
      };
      luaConfigRC.wal-colors = lib.hm.dag.entryAfter ["theme"] (
        if useWal
        then ''
          require("catppuccin").setup({
            transparent_background = true,
            color_overrides = {
              frappe = {
                base     = "${c.color0}",
                mantle   = "${c.color1}",
                crust    = "${c.color2}",
                surface0 = "${c.color3}",
                surface1 = "${c.color4}",
                surface2 = "${c.color5}",
                overlay0 = "${c.color6}",
                text     = "${c.color7}",
                subtext0 = "${c.color8}",
                subtext1 = "${c.color9}",
                yellow   = "${c.color10}",
                green    = "${c.color11}",
                teal     = "${c.color12}",
                blue     = "${c.color13}",
                mauve    = "${c.color14}",
                lavender = "${c.color15}",
              },
            },
          })
          vim.cmd.colorscheme("catppuccin-frappe")

          local transparent_groups = {
            "Normal", "NormalNC", "NormalFloat",
            "SignColumn", "StatusLine", "StatusLineNC",
            "TabLine", "TabLineFill", "TabLineSel",
            "FloatBorder", "Pmenu", "PmenuSbar",
            "NeoTreeNormal", "NeoTreeNormalNC",
          }
          for _, group in ipairs(transparent_groups) do
            vim.api.nvim_set_hl(0, group, { bg = "none", ctermbg = "none" })
          end

          vim.api.nvim_set_hl(0, "Operator",               { fg = "${c.color7}" })
          vim.api.nvim_set_hl(0, "LspInlayHint",           { fg = "${c.color8}", bg = "none" })
          vim.api.nvim_set_hl(0, "Comment",                { fg = "${c.color8}", bg = "none" })
          vim.api.nvim_set_hl(0, "Delimiter",              { fg = "${c.color7}" })
          vim.api.nvim_set_hl(0, "@punctuation.bracket",   { fg = "${c.color7}" })
          vim.api.nvim_set_hl(0, "@punctuation.delimiter", { fg = "${c.color7}" })
          vim.api.nvim_set_hl(0, "@function",              { fg = "${c.color12}" })
          vim.api.nvim_set_hl(0, "@function.call",         { fg = "${c.color12}" })
          vim.api.nvim_set_hl(0, "@function.method",       { fg = "${c.color12}" })
          vim.api.nvim_set_hl(0, "@function.method.call",  { fg = "${c.color12}" })
          vim.api.nvim_set_hl(0, "@function.builtin",      { fg = "${c.color12}" })
          vim.api.nvim_set_hl(0, "@number",                { fg = "${c.color10}" })
          vim.api.nvim_set_hl(0, "@number.float",          { fg = "${c.color10}" })
        ''
        else ""
      );
    };
  };
}
