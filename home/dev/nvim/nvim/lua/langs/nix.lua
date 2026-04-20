return {
  lsp = {
    servers = {
      nixd = {
        settings = {
          nixd = {
            formatting = { command = { "nixfmt" } },
            options = {
              nixos = { expr = '(builtins.getFlake "nixpkgs").legacyPackages.x86_64-linux.nixosConfigurations.default.options' },
            },
          },
        },
      },
    },
  },
  lint = {
    linters_by_ft = {
      nix = { "statix" },
    },
  },
}
