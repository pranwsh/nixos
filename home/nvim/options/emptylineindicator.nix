{...}: {
  programs.nvf.settings.vim.options = {
    # Set the 'eob' (End of Buffer) character to a space
    fillchars = "eob: ";
  };
}
