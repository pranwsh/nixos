{
  pkgs,
  lib,
  ...
}:

# ─────────────────────────────────────────────────────────────────────────────
# To add a new language:
#   1. Create nvim/lua/langs/<name>.lua  (see python.lua for the spec format)
#   2. Add its LSP / linter / formatter binaries to langPackages.<name> below
#   3. Add its treesitter parser to treesitterParsers below
#   4. Rebuild: home-manager switch
# ─────────────────────────────────────────────────────────────────────────────

let

  # ── Per-language external binaries ────────────────────────────────────────
  langPackages = {
    python = with pkgs; [
      pyright
      ruff
    ];
    nix = with pkgs; [
      nixd
      nixfmt
      statix
    ];
    lua = with pkgs; [
      lua-language-server
      selene
    ];
    go = with pkgs; [
      gopls
      golangci-lint
    ];
  };

  # ── Derived ───────────────────────────────────────────────────────────────

  allExtraPackages = lib.flatten (lib.attrValues langPackages);

in
{

  # ── Copy Lua config verbatim into ~/.config/nvim ──────────────────────────
  home.file.".config/nvim" = {
    source = ./nvim;
    recursive = true;
  };

  # ── Neovim + plugins ──────────────────────────────────────────────────────
  programs.neovim = {
    enable = true;
    defaultEditor = true;

    plugins = with pkgs.vimPlugins; [
      # ── LSP ───────────────────────────────────────────────────────────────
      nvim-lspconfig

      # ── Completion ────────────────────────────────────────────────────────
      nvim-cmp
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      cmp-cmdline

      # ── Snippets ──────────────────────────────────────────────────────────
      luasnip
      cmp_luasnip
      friendly-snippets

      # ── Treesitter ────────────────────────────────────────────────────────
      (nvim-treesitter.withPlugins (p: [
        p.lua
        p.nix
        p.c
        p.go
        p.commonlisp
        p.python
        p.prolog
      ]))

      # ── Linting ───────────────────────────────────────────────────────────
      nvim-lint

      # ── Language-specific ─────────────────────────────────────────────────
      rustaceanvim

      # ── UI ────────────────────────────────────────────────────────────────
      catppuccin-nvim
      which-key-nvim
      indent-blankline-nvim

      # ── Mini suite ────────────────────────────────────────────────────────
      mini-nvim

      # md and tex
      vimtex

      # fuzzy find
      telescope-nvim
      plenary-nvim
    ];

    extraPackages = allExtraPackages;
  };
}
