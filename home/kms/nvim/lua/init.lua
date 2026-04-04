-- Load core modules
local lsp = require("core.lsp")
local cmp = require("core.cmp")
local treesitter = require("core.treesitter")
local lint = require("core.lint")
local snippets = require("core.snippets")

-- Load all language configurations from langs/
local lang_files = vim.fn.glob(vim.fn.stdpath("config") .. "/lua/langs/*.lua", false, true)
for _, file in ipairs(lang_files) do
  local name = vim.fn.fnamemodify(file, ":t:r")
  require("langs." .. name)
end

-- After loading languages, finalize setups
lsp.setup_servers()
cmp.setup()
treesitter.setup()
lint.setup()
snippets.setup()
