{
  pkgs,
  lib,
  ...
}: {
  programs.nvf.settings.vim = {
    extraPlugins = with pkgs.vimPlugins; {
      plenary-nvim = {
        package = plenary-nvim;
      };
    };
  };
}
