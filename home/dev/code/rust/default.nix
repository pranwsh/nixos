{ pkgs, ... }:

{
  home.packages = with pkgs; [
    rustc
    cargo
    rust-analyzer
    clippy
    rustfmt
    bacon
    evcxr # Rust REPL
  ];

  home.file."code/rust/.keep".text = "";
}
