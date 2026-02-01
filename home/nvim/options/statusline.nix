{...}: {
  programs.nvf.settings.vim = {
    # Disable the statusline plugin
    statusline.lualine.enable = false;

    # Force Neovim to hide the statusline area
    # 0: never, 1: only if 2+ windows, 2: always, 3: global (one for all windows)
    options.laststatus = 0;
  };
}
