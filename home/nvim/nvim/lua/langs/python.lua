-- langs/python.lua
-- Drop a file like this into langs/ for any language you want to add.

return {
  lsp = {
    servers = {
      pyright = {
        settings = {
          python = {
            analysis = {
              typeCheckingMode = "basic",
              autoImportCompletions = true,
            },
          },
        },
      },
    },
  },

  lint = {
    linters_by_ft = {
      python = { "ruff" },
    },
  },
}
