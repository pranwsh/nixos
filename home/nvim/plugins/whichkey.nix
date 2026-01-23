{lib, ...}: {
  programs.nvf.settings = {
    vim.binds.whichKey = {
      enable = true;
      register = {
        "<leader>le" = "Open Diagnostics";

        # Telescope/Finder (if enabled)
        # "<leader>f" = "+Find";
        # "<leader>ff" = "Find files";
        # "<leader>fg" = "Live grep";
        # "<leader>fb" = "Buffers";

        # Your custom binds
        "<leader>e" = "Toggle Neotree";
      };
      setupOpts = {
        preset = "helix";
        win.border = "rounded";
      };
    };
  };
}
