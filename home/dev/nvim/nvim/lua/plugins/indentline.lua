-- indent_config.lua (or inline in your init.lua)

-- mini.indentscope
require("mini.indentscope").setup({
  symbol = "│",
  options = {
    try_as_border = true,
    border = "both",
    indent_at_cursor = true,
  },
  draw = {
    delay = 50,
    animation = require("mini.indentscope").gen_animation.linear(),
  },
})

-- Disable mini.indentscope in certain filetypes
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "help", "dashboard", "neo-tree", "Trouble", "lazy", "mason", "notify" },
  callback = function()
    vim.b.miniindentscope_disable = true
  end,
})


-- indent-blankline
require("ibl").setup({
  indent = {
    char = "│",
    tab_char = "│",
  },
  scope = {
    enabled = false, -- let mini.indentscope handle scope highlight
  },
  exclude = {
    filetypes = { "help", "dashboard", "neo-tree", "Trouble", "lazy", "mason", "notify" },
  },
})
