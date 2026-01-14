local servers = require("config.lsp.servers")
local keymaps = require("config.lsp.keymaps")

-- Get capabilities from cmp
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Configure each server
for server_name, server_config in pairs(servers) do
  server_config.capabilities = capabilities
  vim.lsp.config[server_name] = server_config
end

-- Enable all servers
vim.lsp.enable(vim.tbl_keys(servers))

-- Setup keymaps
keymaps.setup()
