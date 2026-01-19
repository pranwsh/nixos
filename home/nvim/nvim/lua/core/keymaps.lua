vim.keymap.set('t', '<M-q>', [[<C-\><C-n>]], { noremap = true })

-- Toggle nvim-tree
vim.keymap.set(
  "n",
  "<leader>e",
  "<cmd>NvimTreeToggle<CR>",
  { noremap = true, silent = true, desc = "Toggle file explorer" }
)
