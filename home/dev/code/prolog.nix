{pkgs, ...}: {
  home.packages = with pkgs; [
    swi-prolog
  ];
}
