vim.diagnostic.config({
  virtual_text = true,        -- Show errors inline at end of line
  signs = true,               -- Show E/W/I/H in sign column
  underline = true,           -- Underline the error
  update_in_insert = false,
  severity_sort = true,
})
