local M = {}
function M.setup()
  vim.api.nvim_create_autocmd("FileType", {
    callback = function(ev)
      -- Skip virtual/internal filetypes that have no treesitter parser
      local ft = vim.bo[ev.buf].filetype
      if ft == "" or ft == nil then return end

      -- Check a parser actually exists before trying to start one
      local ok, err = pcall(vim.treesitter.start, ev.buf)
      if not ok and not err:find("no parser") and not err:find("could not be created") then
        vim.notify("[treesitter] " .. err, vim.log.levels.WARN)
      end
    end,
  })

  vim.api.nvim_create_autocmd("BufWritePre", {
    callback = function(ev)
      vim.lsp.buf.format({ bufnr = ev.buf, async = false })
    end,
  })
end

return M
