{pkgs, ...}: {
  home.packages = with pkgs; [
    # Rust toolchain
    rustc
    cargo
    rustfmt
    clippy
    rust-analyzer

    # Debugger
    gdb

    # Build tools
    pkg-config

    # SSL/TLS development libraries (often needed for Rust crates)
    openssl
    pkg-config

    # Optional useful tools
    cargo-edit # cargo add, rm, upgrade
    cargo-watch # auto-rebuild on file changes
    cargo-audit # security audit for dependencies
    cargo-binstall # fast binary installation
    cargo-nextest # alternative test runner
  ];
}
