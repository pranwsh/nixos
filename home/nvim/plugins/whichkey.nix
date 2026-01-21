{lib, ...}: {
  programs.nvf.settings = {
    vim = {
      binds.whichKey = {
        enable = true;

        setupOpts = {
          preset = "helix";
          win.border = "rounded";
        };
      };
    };
  };
}
