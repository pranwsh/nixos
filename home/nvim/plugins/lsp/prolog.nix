{pkgs, ...}: {
  programs.nvf.settings = {
    vim = {
      languages.enableTreesitter = true;

      treesitter.grammars = with pkgs.vimPlugins.nvim-treesitter-parsers; [
        prolog
      ];

      extraPackages = with pkgs; [swi-prolog];

      lsp.servers.prolog_ls = {
        enable = true;
        cmd = [
          "swipl"
          "-g"
          "use_module(library(lsp_server))."
          "-g"
          "lsp_server:main"
          "-t"
          "halt"
          "--"
          "stdio"
        ];
        filetypes = ["prolog"];
      };
    };
  };
}
