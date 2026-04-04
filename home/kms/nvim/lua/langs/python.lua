local lsp = require("core.lsp")
local treesitter = require("core.treesitter")
local lint = require("core.lint")
-- local snippets = require("core.snippets")  -- uncomment if using snippets

lsp.add_server("pyright", {})
treesitter.add_parser("python")
lint.add_linter("python", "flake8")
