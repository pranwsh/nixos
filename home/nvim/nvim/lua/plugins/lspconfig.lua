return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      lua_ls = {
        -- Ensure it uses the system lua-language-server
        cmd = { "lua-language-server" },
      },
      clangd = {
        cmd = { "clangd" },
      },
      -- Add other LSPs you have installed via Nix
    },
  },
}
