{ config, lib, pkgs, ... }:

{
  programs.nvf.settings.vim.maps = {
    normal = {
      # Example: uncomment to add custom keymaps
      # "<C-s>" = {
      #   action = ":w<CR>";
      #   silent = true;
      # };
    };
    
    insert = {
      # Example keymaps
    };
    
    visual = {
      # Example keymaps
    };
  };
}
