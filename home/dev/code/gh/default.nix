{pkgs, ...}: {
  home.packages = with pkgs; [
    gh
    lazygit
  ];
}
