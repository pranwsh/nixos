{ pkgs, ... }: {
  fonts.fontconfig = {
    enable = true;
    defaultFonts.monospace = [ "RobotoMono Nerd Font" ];
  };

  home.packages = with pkgs; [
    nerd-fonts.roboto-mono
  ];
}
