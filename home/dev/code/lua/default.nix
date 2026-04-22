{ pkgs, ... }:

{
  home.packages = with pkgs; [
    lua
    lua-language-server
    stylua
    selene
  ];

  home.file."code/lua/.keep".text = "";
}
