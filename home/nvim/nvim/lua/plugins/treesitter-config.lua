return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    -- Force nvim-treesitter to use the system tree-sitter from Nix
    local tree_sitter_cli = vim.fn.exepath('tree-sitter')
    if tree_sitter_cli ~= '' then
      require('nvim-treesitter.install').command = tree_sitter_cli
    end

    require('nvim-treesitter.install').prefer_git = false
    require('nvim-treesitter.install').compilers = { "gcc" }

    -- Override LazyVim's defaults
    opts.ensure_installed = opts.ensure_installed or {}
    opts.auto_install = false
    
    return opts
  end,
}
