return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        clangd = {
          cmd = { "/etc/profiles/per-user/pranesh/bin/clangd" },
          capabilities = {
            offsetEncoding = { "utf-16" },
          },
        },
      },
    },
  },
}
