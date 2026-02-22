{...}: {
  programs.nvf.settings = {
    vim = {
      tabline.nvimBufferline = {
        enable = true;

        mappings = {
          cycleNext = "L";
          cyclePrevious = "H";
          closeCurrent = "<leader>bd";
        };

        setupOpts.options = {
          seperator_style = [" " " "];
          show_buffer_close_icons = false;
          show_close_icons = false;
          show_tab_indicators = false;
          always_show_bufferline = false;
          indicator.style = "none";
        };
      };
    };
  };
}
