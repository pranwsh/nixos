{ config, lib, pkgs, ... }:
{
  programs.nvf.settings.vim = {
    viAlias = false;
    vimAlias = true;
    
    clipboard.enable = true;
    clipboard.registers = "unnamedplus";
    
    lineNumberMode = "relNumber";
    
    preventJunkFiles = true;
    
    bell = "none";
    
    searchCase = "smart";
    
    globals.mapleader = " ";
    
    options = {
      # Tab settings
      tabstop = 2;
      shiftwidth = 2;
      autoindent = true;
      
      # Command height
      cmdheight = 1;
      
      # Update time
      updatetime = 300;
      
      # Mouse support
      mouse = "a";
      
      # Split behavior
      splitbelow = true;
      splitright = true;
      
      # Timeout for mappings
      tm = 500;
    };
  };
}
