{lib, ...}: {
  programs.nvf.settings = {
    vim = {
      autocomplete.nvim-cmp = {
        enable = true;

        # 1. Use the built-in mapping options (Safe & Type-checked)
        mappings = {
          complete = "<C-Space>";
          confirm = "<CR>";
          next = "<Tab>";
          previous = "<S-Tab>";
          scrollDocsUp = "<C-d>";
          scrollDocsDown = "<C-f>";
        };

        # 2. Use setupOpts only for things nvf doesn't have a top-level option for
        setupOpts = {
          sources = lib.mkForce [
            {name = "nvim_lsp";}
            {name = "luasnip";}
            {name = "path";}
            {name = "buffer";}
          ];
          window = {
            completion = {border = "rounded";};
            documentation = {border = "rounded";};
          };
        };
      };
    };
  };
}
