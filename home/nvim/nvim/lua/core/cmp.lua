-- ─────────────────────────────────────────────────────────────────────────────
-- core/cmp.lua
-- Completion setup using nvim-cmp + luasnip.
-- All sources are generic (LSP, snippets, buffer, path).
-- Language-specific completion sources should be added via langs/ specs
-- if/when needed (pass extra_sources into setup()).
-- ─────────────────────────────────────────────────────────────────────────────

local M = {}

function M.setup(extra_sources)
  extra_sources = extra_sources or {}

  local cmp     = require("cmp")
  local luasnip = require("luasnip")

  -- Helper: are we inside a snippet and can jump?
  local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0
      and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]
           :sub(col, col):match("%s") == nil
  end

  cmp.setup({
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },

    window = {
      completion    = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },

    mapping = cmp.mapping.preset.insert({
      ["<C-b>"]     = cmp.mapping.scroll_docs(-4),
      ["<C-f>"]     = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<C-e>"]     = cmp.mapping.abort(),

      ["<CR>"] = cmp.mapping.confirm({ select = false }),

      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_locally_jumpable() then
          luasnip.expand_or_jump()
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end, { "i", "s" }),

      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.locally_jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { "i", "s" }),
    }),

    sources = cmp.config.sources(
      vim.list_extend({
        { name = "nvim_lsp", priority = 1000 },
        { name = "luasnip",  priority = 750  },
        { name = "buffer",   priority = 500  },
        { name = "path",     priority = 250  },
      }, extra_sources)
    ),

    formatting = {
      format = function(entry, item)
        local source_labels = {
          nvim_lsp = "[LSP]",
          luasnip  = "[Snip]",
          buffer   = "[Buf]",
          path     = "[Path]",
        }
        item.menu = source_labels[entry.source.name] or "[?]"
        return item
      end,
    },
  })

  -- ── Cmdline ──────────────────────────────────────────────────────────────
  cmp.setup.cmdline({ "/", "?" }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = { { name = "buffer" } },
  })

  cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = "path"    },
      { name = "cmdline" },
    }),
  })
end

return M
