{lib, ...}: {
  programs.nvf.settings = {
    vim.filetree = {
      neo-tree = {
        enable = true;

        setupOpts = {
          add_blank_line_at_top = true;
          window.width = 20;
        };
      };
    };
  };
}
