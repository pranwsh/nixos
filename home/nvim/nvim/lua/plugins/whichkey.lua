local wk = require("which-key")
wk.setup({
  win = {
    border = "rounded",
  },
})
wk.add({
  { "<leader>", group = "leader" },
  { "g",        group = "goto" },
})
