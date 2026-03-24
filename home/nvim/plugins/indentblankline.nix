{...}: {
  programs.nvf.settings = {
    vim = {
      mini.indentscope.enable = true;

      visuals.indent-blankline = {
        enable = true;
        setupOpts = {
          indent = {
            char = "│";
          };
          scope.enabled = false; # disable ibl's own scope highlight, let mini.indentscope handle it
        };
      };

      luaConfigRC.indentscope = ''
        vim.api.nvim_create_autocmd("FileType", {
          pattern = "*",
          callback = function()
            vim.b.miniindentscope_config = {
              symbol = "│",
            }
          end,
        })
      '';
    };
  };
}
