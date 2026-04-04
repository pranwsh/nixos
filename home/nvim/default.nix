{ config, pkgs, lib, ... }:

# ─────────────────────────────────────────────────────────────────────────────
# To add a new language:
#   1. Create nvim/lua/langs/<name>.lua  (see python.lua for the spec format)
#   2. Add its LSP / linter / formatter binaries to langPackages.<name> below
#   3. Add its treesitter parser to the treesitterParsers list below
#   4. Rebuild: home-manager switch
# ─────────────────────────────────────────────────────────────────────────────

let

  # ── Per-language external binaries ────────────────────────────────────────
  # Keys should match the name of the file in nvim/lua/langs/ (cosmetic only).
  langPackages = {
    python = with pkgs; [
      pyright   # LSP
      ruff      # linter / formatter
    ];

    # nix = with pkgs; [ nil nixpkgs-fmt ];  # ← uncomment to add Nix
    # lua = with pkgs; [ lua-language-server stylua ];
  };

  # ── Treesitter parsers ────────────────────────────────────────────────────
  treesitterParsers = p: [
    # Core / meta
    p.lua p.vim p.vimdoc p.query p.regex

    # Markup / config
    p.bash p.json p.jsonc p.yaml p.toml
    p.markdown p.markdown_inline

    # Languages
    p.python

    # p.nix          # ← add when you add a nix lang file
    # p.rust
    # p.go
    # p.typescript p.tsx p.javascript
  ];

  # ── Build derived values ──────────────────────────────────────────────────
  treesitterWithParsers =
    pkgs.vimPlugins.nvim-treesitter.withPlugins treesitterParsers;

  allExtraPackages =
    lib.flatten (lib.attrValues langPackages);

in
{
  # ── Copy the Lua config verbatim into ~/.config/nvim ──────────────────────
  home.file.".config/nvim" = {
    source   = ./nvim;
    recursive = true;
  };

  # ── Neovim + plugins (all from nixpkgs, zero runtime package managers) ────
  programs.neovim = {
    enable        = true;
    defaultEditor = true;

    plugins = with pkgs.vimPlugins; [
      # ── LSP ──────────────────────────────────────────────────────────────
      nvim-lspconfig

      # ── Completion ───────────────────────────────────────────────────────
      nvim-cmp
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      cmp-cmdline

      # ── Snippets ─────────────────────────────────────────────────────────
      luasnip
      cmp_luasnip
      friendly-snippets

      # ── Treesitter ───────────────────────────────────────────────────────
      treesitterWithParsers

      # ── Linting ──────────────────────────────────────────────────────────
      nvim-lint
    ];

    # Language-server / linter / formatter binaries go on PATH for neovim
    extraPackages = allExtraPackages;
  };
}
