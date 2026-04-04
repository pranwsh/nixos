{config, pkgs, ...}:
{
  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      # LSP
      nvim-lspconfig
      # Autocompletion
      nvim-cmp
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      cmp-cmdline
      # Snippets
      luasnip
      cmp_luasnip
      # Linting
      nvim-lint
      # Treesitter
      # nvim-treesitter.withAllGrammars
      (nvim-treesitter.withPlugins (p: p.allGrammars))
      # Utilities
      plenary-nvim
    ];
  };
  home.file.".config/nvim" = {
    source = ./nvim;
    recursive = true;
  };
}
