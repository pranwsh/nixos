{...}: {
  programs.nvf.settings.vim.maps = {
    normal = {
      "<leader>e" = {
        action = "<cmd>Neotree toggle<CR>";
        silent = true;
        desc = "Toggle Neotree";
      };
    };

    insert = {
      # Example keymaps
    };

    visual = {
      # Example keymaps
    };
  };
}
