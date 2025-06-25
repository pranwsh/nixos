return {
  {
    "maan2003/lsp_lines.nvim",
    config = function()
      require("lsp_lines").setup()

      vim.diagnostic.config({
        virtual_text = false,  -- Disable virtual text diagnostics
        virtual_lines = true,  -- Enable virtual lines diagnostics
      })

      -- Optional: keymap to toggle between virtual text and lines
      vim.keymap.set("n", "<Leader>lt", function()
        local current = vim.diagnostic.config()
        vim.diagnostic.config({
          virtual_text = not current.virtual_text,
          virtual_lines = not current.virtual_lines,
        })
      end, { desc = "Toggle LSP diagnostics display mode" })
    end,
  }
}
