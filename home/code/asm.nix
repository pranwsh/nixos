{pkgs, ...}: {
  home.packages = with pkgs; [
    nasm
  ];
  # This creates the physical file asm-lsp is looking for
  home.file.".asm-lsp.toml".text = ''
    assembler = "gas"
    architecture = "x86"
    mode = "32"
    diagnostics = true
  '';
}
