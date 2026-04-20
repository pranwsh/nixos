-- telescope.lua (or wherever you configure plugins)
local telescope = require("telescope")
local builtin = require("telescope.builtin")

telescope.setup({
  defaults = {
    file_ignore_patterns = { "%.git/", "node_modules/", "%.DS_Store" },
    layout_strategy = "horizontal",
    sorting_strategy = "ascending",
    layout_config = {
      prompt_position = "top",
    },
  },
  pickers = {
    find_files = {
      hidden = true, -- show dotfiles
      follow = true, -- follow symlinks
    },
    buffers = {
      sort_mru = true, -- most recently used first
      ignore_current_buffer = true,
    },
  },
})

-- Keymaps
local map = vim.keymap.set

map("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
map("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
map("n", "<leader>fb", builtin.buffers, { desc = "Switch buffers" })
map("n", "<leader>fr", builtin.oldfiles, { desc = "Recent files" })
map("n", "<leader>fh", builtin.help_tags, { desc = "Help tags" })

-- Optional: <C-p> as a classic muscle-memory alias for find_files
map("n", "<C-p>", builtin.find_files, { desc = "Find files" })
