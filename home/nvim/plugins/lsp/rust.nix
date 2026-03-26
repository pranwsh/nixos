{...}: {
  programs.nvf.settings = {
    vim = {
      languages = {
        rust = {
          enable = true;
          treesitter.enable = true;
          lsp.enable = true;
          dap.enable = true;
          format.enable = true;
          extensions.crates-nvim.enable = true;
        };
      };

      luaConfigRC.rust-extra = ''
        -- Set as a function so rustaceanvim defers evaluation, and we
        -- fully replace nvf's broken `on_attach = default_on_attach` reference.
        vim.g.rustaceanvim = function()
          return {
            server = {

              on_attach = function(client, bufnr)
                -- Standard LSP keymaps (replaces nvf's default_on_attach)
                local map = function(keys, cmd, desc)
                  vim.keymap.set("n", keys, cmd, { buffer = bufnr, silent = true, desc = desc })
                end

                map("gd",         vim.lsp.buf.definition,      "Go to Definition")
                map("gD",         vim.lsp.buf.declaration,     "Go to Declaration")
                map("gr",         vim.lsp.buf.references,      "Go to References")
                map("gi",         vim.lsp.buf.implementation,  "Go to Implementation")
                map("gy",         vim.lsp.buf.type_definition, "Go to Type Definition")
                map("<leader>rn", vim.lsp.buf.rename,          "Rename Symbol")
                map("<leader>ca", vim.lsp.buf.code_action,     "Code Action")
                map("<C-k>",      vim.lsp.buf.signature_help,  "Signature Help")
                map("[d",         vim.diagnostic.goto_prev,    "Prev Diagnostic")
                map("]d",         vim.diagnostic.goto_next,    "Next Diagnostic")
                map("<leader>e",  vim.diagnostic.open_float,   "Show Diagnostic")

                -- Rustaceanvim-specific commands
                map("K",           function() vim.cmd.RustLsp({ "hover", "actions" }) end, "Rust Hover Actions")
                map("<leader>ra",  function() vim.cmd.RustLsp("codeAction")             end, "Rust Code Action")
                map("<leader>re",  function() vim.cmd.RustLsp("expandMacro")            end, "Expand Macro")
                map("<leader>rr",  function() vim.cmd.RustLsp("runnables")              end, "Runnables")
                map("<leader>rd",  function() vim.cmd.RustLsp("debuggables")            end, "Debuggables")
                map("<leader>rt",  function() vim.cmd.RustLsp("testables")              end, "Testables")
                map("<leader>rp",  function() vim.cmd.RustLsp("parentModule")           end, "Parent Module")
                map("<leader>rj",  function() vim.cmd.RustLsp("joinLines")              end, "Join Lines")

                vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
              end,

              default_settings = {
                ["rust-analyzer"] = {
                  cargo = {
                    allFeatures = true,
                    buildScripts = { enable = true },
                  },
                  check = { command = "clippy" },
                  procMacro = { enable = true },

                  inlayHints = {
                    chainingHints      = { enable = true },
                    parameterHints     = { enable = true },
                    typeHints          = { enable = true },
                    closureReturnTypeHints = { enable = "always" },
                    lifetimeElisionHints   = { enable = "skip_trivial" },
                  },
                  completion = { autoimport = { enable = true } },
                  lens = {
                    enable = true,
                    run            = { enable = true },
                    debug          = { enable = true },
                    implementations = { enable = true },
                  },
                },
              },
            },
          }
        end

        vim.api.nvim_create_autocmd("BufWritePre", {
          pattern = "*.rs",
          callback = function()
            vim.lsp.buf.format({ timeout_ms = 3000, async = false })
          end,
        })
      '';
    };
  };
}
