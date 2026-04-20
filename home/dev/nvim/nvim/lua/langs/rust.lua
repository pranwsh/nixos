-- langs/rust.lua
return {
  -- rust-analyzer is owned by rustaceanvim, not lsp.lua
  lint = {
    linters_by_ft = {
      rust = { "clippy" },
    },
  },
}
