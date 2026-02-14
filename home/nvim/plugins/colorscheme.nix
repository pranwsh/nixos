{...}: {
  programs.nvf.settings = {
    vim = {
      theme = {
        enable = true;
        name = "catppuccin";
        style = "frappe";
        transparent = true;

        base16-colors = {
        };
      };

      visuals = {
        nvim-web-devicons.enable = true;
      };
    };
  };
}
# {walNix, ...}: let
#   c = (import "${walNix}/colors.nix").colorscheme;
# in {
#   programs.nvf.settings = {
#     vim = {
#       theme = {
#         enable = true;
#         name = "catppuccin";
#         style = "frappe";
#         transparent = true;
#       };
#
#       # This runs AFTER everything else (including theme)
#       luaConfigPost = ''
#         require("catppuccin").setup({
#           color_overrides = {
#           i
#             frappe = {
#               -- Base colors
#               base = "${c.color0}",
#               mantle = "${c.color1}",
#               crust = "${c.color2}",
#
#               -- Surface colors
#               surface0 = "${c.color3}",
#               surface1 = "${c.color4}",
#               surface2 = "${c.color5}",
#
#               -- Overlay colors
#               overlay0 = "${c.color6}",
#               overlay1 = "${c.color7}",
#               overlay2 = "${c.color8}",
#
#               -- Text colors
#               text = "${c.color5}",
#               subtext1 = "${c.color6}",
#               subtext0 = "${c.color7}",
#
#               -- Accent colors
#               blue = "${c.color13}",
#               lavender = "${c.color13}",
#               sapphire = "${c.color12}",
#               sky = "${c.color12}",
#               teal = "${c.color12}",
#
#               green = "${c.color11}",
#               yellow = "${c.color10}",
#               peach = "${c.color9}",
#
#               red = "${c.color8}",
#               maroon = "${c.color8}",
#               mauve = "${c.color14}",
#               pink = "${c.color14}",
#               flamingo = "${c.color15}",
#               rosewater = "${c.color15}",
#             },
#           },
#           transparent_background = true,
#         })
#
#         vim.cmd.CatppuccinCompile()
#         vim.cmd.colorscheme("catppuccin-frappe")
#       '';
#
#       visuals = {
#         nvim-web-devicons.enable = true;
#       };
#     };
#   };
# }

