{
  pkgs,
  lib,
  ...
}:

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
    cpp = with pkgs; [
      clang-tools
      cppcheck
    ];

    rust = with pkgs; [

      # Rust LSP. NB: this is `pkgs.rust-analyzer` at top level; there is no
      # `rustPackages.rust-analyzer` attribute in nixpkgs.
      #
      # Preferred over rustup's `~/.cargo/bin/rust-analyzer`, which is a proxy
      # shim that fails when the component is not installed.
      rust-analyzer

      # `checkOnSave.command = "clippy"` in the rustaceanvim config needs a real
      # clippy on PATH; the rustup shim is unreliable, so take it from Nix.
      clippy

      # Used by the BufWritePre format hook and rust-analyzer's formatter.
      rustfmt

      # cargo/rustc are included so the toolchain versions match clippy's;
      # a mixed toolchain makes `cargo clippy` fail inside rust-analyzer.
      cargo
      rustc
    ];

    java = with pkgs; [
      # Java LSP (Eclipse JDT LS). NB: nixpkgs has no `jdtls` alias; the
      # attribute is `jdt-language-server`. Its wrapper hardcodes its own
      # JDK, so no separate `jdk` needs to be on PATH.
      jdt-language-server

      # Linter behind nvim-lint's `checkstyle` linter. It resolves its
      # bundled /google_checks.xml from inside the jar, so no external
      # config file is required.
      checkstyle
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
    sideloadInitLua = true;
    withRuby = false;
    withPython3 = false;

    plugins = with pkgs.vimPlugins; [
      # ── LSP ───────────────────────────────────────────────────────────────
      nvim-lspconfig
      nvim-jdtls

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

      # git
      gitsigns-nvim

      # ── Treesitter ────────────────────────────────────────────────────────
      (nvim-treesitter.withPlugins (p: [
        p.lua
        p.nix
        p.c
        p.cpp
        p.go
        p.commonlisp
        p.python
        p.java
p.rust
      ]))

      # ── Linting ───────────────────────────────────────────────────────────
      nvim-lint

      # ── Language-specific ─────────────────────────────────────────────────
      rustaceanvim

      # ── UI ────────────────────────────────────────────────────────────────
      catppuccin-nvim
      which-key-nvim
      indent-blankline-nvim
      colorizer

      # ── Mini suite ────────────────────────────────────────────────────────
      mini-nvim

      # md and tex
      vimtex

      # fuzzy find
      telescope-nvim
      plenary-nvim

      # AI
      opencode-nvim
    ];

    extraPackages = allExtraPackages;
  };
}
