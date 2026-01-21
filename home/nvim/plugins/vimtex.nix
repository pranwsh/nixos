{pkgs, ...}: {
  config.vim = {
    startPlugins = [pkgs.vimPlugins.vimtex];

    # Add VimTeX configuration
    luaConfigRC.vimtex = ''
      vim.g.vimtex_view_method = 'zathura'
      vim.g.vimtex_compiler_method = 'latexmk'
      vim.g.vimtex_compiler_latexmk = {
        build_dir = 'build',
        options = {
          '-pdf',
          '-shell-escape',
          '-verbose',
          '-file-line-error',
          '-synctex=1',
          '-interaction=nonstopmode',
        }
      }
    '';
  };
}
