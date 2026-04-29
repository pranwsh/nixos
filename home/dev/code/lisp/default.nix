{ pkgs, ... }:

{
  home.packages = with pkgs; [
    sbcl
    sbclPackages.quicklisp-starter
  ];
}
