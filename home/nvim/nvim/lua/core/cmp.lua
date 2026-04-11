-- core/cmp.lua
-- nvim-cmp with LuaSnip source. Exposes M.capabilities for lsp.lua.

local M = {}

-- Built once in setup(), read by lsp.lua via M.capabilities.
M.capabilities = vim.lsp.protocol.make_client_capabilities()

function M.setup()
  local ok, cmp = pcall(require, "cmp")
  if not ok then return end

  local ls_ok, ls = pcall(require, "luasnip")

  -- Extend capabilities with whatever cmp_nvim_lsp adds, if available.
  local caps_ok, cmp_lsp = pcall(require, "cmp_nvim_lsp")
  if caps_ok then
    M.capabilities = cmp_lsp.default_capabilities()
  end

  cmp.setup({
    snippet = {
      expand = function(args)
        if ls_ok then ls.lsp_expand(args.body) end
      end,
    },

    window = {
      completion    = cmp.config.window.bordered({ border = "rounded" }),
      documentation = cmp.config.window.bordered({ border = "rounded" }),
    },

    mapping = cmp.mapping.preset.insert({
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<C-e>"]     = cmp.mapping.abort(),
      ["<CR>"]      = cmp.mapping.confirm({ select = true }),
      ["<Tab>"]     = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif ls_ok and ls.expand_or_jumpable() then
          ls.expand_or_jump()
        else
          fallback()
        end
      end, { "i", "s" }),
      ["<S-Tab>"]   = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif ls_ok and ls.jumpable(-1) then
          ls.jump(-1)
        else
          fallback()
        end
      end, { "i", "s" }),
    }),

    sources = cmp.config.sources({
      { name = "nvim_lsp" },
      { name = "luasnip"  },
      { name = "buffer"   },
      { name = "path"     },
    }),
  })
end

return M
