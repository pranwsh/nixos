{ pkgs, ... }:

{
  home.packages = with pkgs; [
    (texlive.combine {
      inherit (texlive) scheme-full;
    })
    texlab
    zathura
  ];

  home.file."code/latex/.keep".text = "";
}
