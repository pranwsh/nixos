local M = {}

function M.setup(servers)
  local capabilities = require("core.cmp").capabilities

  local function on_attach(_, bufnr)
    local map = function(keys, fn, desc)
      vim.keymap.set("n", keys, fn, { buffer = bufnr, desc = desc })
    end
    map("gd", vim.lsp.buf.definition, "Go to definition")
    map("gD", vim.lsp.buf.declaration, "Go to declaration")
    map("gr", vim.lsp.buf.references, "References")
    map("gi", vim.lsp.buf.implementation, "Go to implementation")
    map("K", function() vim.lsp.buf.hover({ border = "rounded" }) end, "Hover docs")
    map("<leader>rn", vim.lsp.buf.rename, "Rename symbol")
    map("<leader>ca", vim.lsp.buf.code_action, "Code action")
    map("<leader>f", function() vim.lsp.buf.format({ async = true }) end, "Format buffer")
    map("<leader>la", vim.lsp.buf.code_action, "Available fixes")
    map("<leader>le", function()
      vim.diagnostic.open_float(nil, { focus = false, scope = "line" })
    end, "Expand error")
  end

  for server, opts in pairs(servers) do
    vim.lsp.config(server, vim.tbl_deep_extend("force", {
      capabilities = capabilities,
      on_attach    = on_attach,
    }, opts))
    vim.lsp.enable(server)
  end
end

return M
