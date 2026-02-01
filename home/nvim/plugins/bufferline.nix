{...}: {
  programs.nvf.settings = {
    vim = {
      tabline.nvimBufferline = {
        enable = true;

        setupOpts.options = {
          seperator_style = "slope";
          show_buffer_close_icons = false;
        };
      };
    };
  };
}
