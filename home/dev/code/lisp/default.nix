{ pkgs, ... }:

{
  home.packages = with pkgs; [
    sbcl
    sbclPackages.quicklisp-starter
  ];

  home.file."code/lisp/.keep".text = "";
}
