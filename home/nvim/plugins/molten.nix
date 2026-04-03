# molten.nix — drop into your nvf modules and import it
# Tested with nvf >= 0.6
{
  pkgs,
  lib,
  ...
}: let
  # ── Python environment ──────────────────────────────────────────────────
  # All packages molten-nvim needs at runtime.
  # pnglatex is not yet in nixpkgs; build it inline.
  pnglatex = pkgs.python3Packages.buildPythonPackage rec {
    pname = "pnglatex";
    version = "1.1";
    src = pkgs.python3Packages.fetchPypi {
      inherit pname version;
      sha256 = "sha256-qyYMzAh+lOJVWFb3b1MhXCn7hEgLuEMJHg3XeCuHdU=";
    };
    doCheck = false;
  };

  moltenPython = pkgs.python3.withPackages (ps:
    with ps; [
      pynvim
      jupyter-client
      cairosvg
      pnglatex # the inline derivation above
      # optional but recommended
      nbformat
      pillow
    ]);
in {
  programs.nvf.settings.vim = {
    # ── Runtime dependencies ──────────────────────────────────────────────
    extraPackages = with pkgs; [
      moltenPython # python3 host with all required packages
      imagemagick # image.nvim backend fallback
      # for kitty / ueberzug backends (pick one):
      # kitty        # if using kitty terminal
      # ueberzugpp   # if using ueberzug++ backend
    ];

    # ── Extra plugins (not natively managed by nvf) ───────────────────────
    extraPlugins = with pkgs.vimPlugins; {
      image-nvim = {
        package = image-nvim;
      };
      molten-nvim = {
        package = molten-nvim;
        after = ["image-nvim"]; # image.nvim must load first
      };
    };

    # ── Lua configuration ─────────────────────────────────────────────────
    extraConfigLua = ''
      -- ── Tell neovim where the molten python lives ──────────────────────
      vim.g.python3_host_prog = "${moltenPython}/bin/python3"

      -- ── image.nvim ─────────────────────────────────────────────────────
      require("image").setup({
        backend                        = "kitty",   -- or "ueberzug"
        integrations                   = {},
        max_width                      = nil,
        max_height                     = nil,
        max_width_window_percentage    = math.huge,
        max_height_window_percentage   = math.huge,
        window_overlap_clear_enabled   = true,
        window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
        editor_only_render_when_focused = false,
        use_magick_rock                = false,     -- uses imagemagick CLI
        hijack_file_patterns           = { "*.png", "*.jpg", "*.gif", "*.svg" },
      })

      -- ── molten-nvim core options ────────────────────────────────────────
      vim.g.molten_image_provider          = "image.nvim"
      vim.g.molten_output_win_max_height   = 20
      vim.g.molten_output_win_max_width    = 80
      vim.g.molten_auto_open_output        = false
      vim.g.molten_wrap_output             = true
      vim.g.molten_virt_text_output        = true
      vim.g.molten_virt_lines_off_by_1     = true
      vim.g.molten_copy_output             = false
      vim.g.molten_enter_output_behavior   = "open_then_enter"

      -- ── Keymaps (<localleader> = \\ by default) ─────────────────────────
      local map = function(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, { silent = true, desc = desc })
      end

      -- Lifecycle
      map("n", "<localleader>mi", "<cmd>MoltenInit<CR>",               "Molten: init kernel")
      map("n", "<localleader>mk", "<cmd>MoltenInterrupt<CR>",          "Molten: interrupt kernel")
      map("n", "<localleader>mr", "<cmd>MoltenRestart!<CR>",           "Molten: restart kernel")
      map("n", "<localleader>mq", "<cmd>MoltenDeinit<CR>",             "Molten: deinit kernel")

      -- Evaluation
      map("n", "<localleader>e",  "<cmd>MoltenEvaluateLine<CR>",       "Molten: eval line")
      map("v", "<localleader>e",  ":<C-u>MoltenEvaluateVisual<CR>gv",  "Molten: eval selection")
      map("n", "<localleader>ec", "<cmd>MoltenEvaluateOperator<CR>",   "Molten: eval operator")
      map("n", "<localleader>rr", "<cmd>MoltenReevaluateCell<CR>",     "Molten: re-eval cell")
      map("n", "<localleader>ra", "<cmd>MoltenReevaluateAll<CR>",      "Molten: re-eval all")

      -- Output window
      map("n", "<localleader>mo", "<cmd>MoltenShowOutput<CR>",         "Molten: show output")
      map("n", "<localleader>mh", "<cmd>MoltenHideOutput<CR>",         "Molten: hide output")
      map("n", "<localleader>md", "<cmd>MoltenDelete<CR>",             "Molten: delete cell")

      -- Navigation
      map("n", "]c",  "<cmd>MoltenNext<CR>",                           "Molten: next cell")
      map("n", "[c",  "<cmd>MoltenPrev<CR>",                           "Molten: prev cell")

      -- Import / Export (jupyter notebook ↔ lua)
      map("n", "<localleader>nb", "<cmd>MoltenImportOutput<CR>",       "Molten: import notebook")
      map("n", "<localleader>ns", "<cmd>MoltenExportOutput!<CR>",      "Molten: export notebook")
    '';
  };
}
