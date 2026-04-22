{ pkgs, ... }:

{
  home.packages = with pkgs; [
    go
    gopls
    delve
    gotests
    gomodifytags
    impl
    golangci-lint
  ];

  home.file."code/go/.keep".text = "";
}
