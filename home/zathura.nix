{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    zathura
  ];

  home.file.".config/zathura/zathurarc".text = ''
    # use global clipboard
    set selection-clipboard clipboard

    # enable recolor and keep hue
    set recolor true
    set recolor-keephue true

    # transparent background (alpha 00)
    set recolor-lightcolor "rgba(0, 0, 0, .42)"

    # opaque white text (alpha ff)
    set recolor-darkcolor "rgba(255, 255, 255, 255)"
  '';
}
