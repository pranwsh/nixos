{pkgs, ...}: {
  programs.nvf.settings = {
    vim = {
      languages.enableTreesitter = true;

      treesitter.grammars = with pkgs.vimPlugins.nvim-treesitter-parsers; [
        commonlisp
      ];
    };
  };
}
