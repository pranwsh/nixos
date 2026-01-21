{pkgs, ...}: {
  programs.nvf.settings.vim = {
    startPlugins = [pkgs.vimPlugins.vimtex];

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

      vim.g.vimtex_quickfix_open_on_warning = 0
    '';
  };
}
