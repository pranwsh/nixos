return {
  lsp = {
    servers = {
      clangd = {
        cmd = {
          "clangd",
          "--background-index",
          "--clang-tidy",
          "--header-insertion=iwyu",
          "--completion-style=detailed",
          "--function-arg-placeholders",
          "--fallback-style=llvm",
        },
      },
    },
  },
  lint = {
    linters_by_ft = {
      c = { "cppcheck" },
      cpp = { "cppcheck" },
    },
  },
}
