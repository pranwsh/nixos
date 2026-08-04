# binds/variables.nix
{ ... }: {
  wayland.windowManager.hyprland.settings = {
    mainMod = {
      _var = "SUPER";
    };
    terminal = {
      _var = "kitty";
    };
    browser = {
      _var = "zen-beta";
    };
    spotify = {
      _var = "spotify";
    };
    menu = {
      _var = "wofi";
    };
    chromium = {
      _var = "chromium";
    };
  };
}
