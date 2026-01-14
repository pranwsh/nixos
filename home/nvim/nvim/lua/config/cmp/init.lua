local cmp = require("cmp")
local luasnip = require("luasnip")
local mappings = require("config.cmp.mappings")

-- Load snippets
require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = mappings.get(cmp, luasnip),
  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer" },
  },
})
