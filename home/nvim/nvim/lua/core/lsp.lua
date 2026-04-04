-- ─────────────────────────────────────────────────────────────────────────────
-- core/lsp.lua
-- Generic LSP wiring. Receives a flat table of { server_name = lspconfig_opts }
-- built by lua/init.lua from all langs/*.lua files.
-- Nothing in here is language-specific.
-- ─────────────────────────────────────────────────────────────────────────────

local M = {}

function M.setup(servers)
  -- ── Diagnostic display ─────────────────────────────────────────────────
  vim.diagnostic.config({
    virtual_text = {
      prefix = "●",
      source  = "if_many",
    },
    float = {
      border = "rounded",
      source = true,
    },
    signs          = true,
    underline      = true,
    update_in_insert = false,
    severity_sort  = true,
  })

  -- ── Signs ──────────────────────────────────────────────────────────────
  local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
  end

  -- ── Capabilities (extended by cmp) ─────────────────────────────────────
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  local ok_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
  if ok_cmp then
    capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
  end

  -- ── Attach keymaps (only when an LSP is active on the buffer) ──────────
  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspAttach", { clear = true }),
    callback = function(ev)
      local buf = ev.buf
      local function map(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, { buffer = buf, silent = true, desc = desc })
      end

      map("n", "gd",         vim.lsp.buf.definition,     "Go to definition")
      map("n", "gD",         vim.lsp.buf.declaration,    "Go to declaration")
      map("n", "gi",         vim.lsp.buf.implementation, "Go to implementation")
      map("n", "gr",         vim.lsp.buf.references,     "Go to references")
      map("n", "K",          vim.lsp.buf.hover,          "Hover documentation")
      map("n", "<C-k>",      vim.lsp.buf.signature_help, "Signature help")
      map("n", "<leader>rn", vim.lsp.buf.rename,         "Rename symbol")
      map("n", "<leader>ca", vim.lsp.buf.code_action,    "Code action")
      map("n", "<leader>f",
        function() vim.lsp.buf.format({ async = true }) end, "Format buffer")
      map("n", "[d", vim.diagnostic.goto_prev, "Prev diagnostic")
      map("n", "]d", vim.diagnostic.goto_next, "Next diagnostic")
      map("n", "<leader>e", vim.diagnostic.open_float, "Show diagnostic float")
      map("n", "<leader>dl", vim.diagnostic.setloclist, "Diagnostics → loclist")
    end,
  })

  -- ── Register every server supplied by langs ─────────────────────────────
  local lspconfig = require("lspconfig")

  for server, opts in pairs(servers) do
    -- Each server inherits shared capabilities; opts may override any field
    opts.capabilities = vim.tbl_deep_extend(
      "force",
      capabilities,
      opts.capabilities or {}
    )
    lspconfig[server].setup(opts)
  end
end

return M
