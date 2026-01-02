{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    zathura
  ];

  home.file.".config/zathura/zathurarc".text = ''
    set selection-clipboard clipboard

    set recolor true
    set recolor-keephue true

    set recolor-lightcolor "rgba(0, 0, 0, .42)"

    set recolor-darkcolor "rgba(255, 255, 255, 255)"
  '';
}
