return {
  lsp = {
    servers = {
      gopls = {
        settings = {
          gopls = {
            analyses = {
              unusedparams = true,
              shadow = true,
            },
            staticcheck = true,
            gofumpt = true,
          },
        },
      },
    },
  },
  lint = {
    linters_by_ft = {
      go = { "golangcilint" },
    },
  },
}
