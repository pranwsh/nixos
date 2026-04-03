{pkgs, ...}: {
  home.packages = with pkgs; [
    clisp
  ];
}
