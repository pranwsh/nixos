{pkgs, ...}: {
  home.packages = with pkgs; [
    gh
    lazygit
  ];

  home.file."code/.keep".text = "";
}
