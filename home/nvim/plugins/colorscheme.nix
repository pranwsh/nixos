{...}: {
  programs.nvf.settings = {
    vim = {
      theme = {
        enable = true;
        name = "catppuccin";
        style = "frappe";
        transparent = true;

        base16-colors = {
        };
      };

      visuals = {
        nvim-web-devicons.enable = true;
      };
    };
  };
}
