{...}: {
  programs.nvf.settings = {
    vim = {
      languages = {
        rust = {
          enable = true;
          treesitter.enable = true;
          lsp.enable = false;
          dap.enable = true;
          format.enable = true;
          # No crates-nvim, no extensions block
        };
      };
      luaConfigRC.rustaceanvim = ''
        vim.g.rustaceanvim = function()
          return {
            server = {
              on_attach = function(client, bufnr)
                local map = function(mode, keys, cmd, desc)
                  vim.keymap.set(mode, keys, cmd, {
                    buffer  = bufnr,
                    silent  = true,
                    desc    = "Rust: " .. desc,
                  })
                end
                -- Standard LSP
                map("n", "gd",          vim.lsp.buf.definition,      "Go to Definition")
                map("n", "gD",          vim.lsp.buf.declaration,     "Go to Declaration")
                map("n", "gr",          vim.lsp.buf.references,      "Go to References")
                map("n", "gi",          vim.lsp.buf.implementation,  "Go to Implementation")
                map("n", "gy",          vim.lsp.buf.type_definition, "Go to Type Definition")
                map("n", "<leader>rn",  vim.lsp.buf.rename,          "Rename Symbol")
                map("n", "<C-k>",       vim.lsp.buf.signature_help,  "Signature Help")
                map("n", "[d",          vim.diagnostic.goto_prev,    "Prev Diagnostic")
                map("n", "]d",          vim.diagnostic.goto_next,    "Next Diagnostic")
                map("n", "<leader>e",   vim.diagnostic.open_float,   "Show Diagnostic")
                -- Rustaceanvim-specific
                map("n", "K",           function() vim.cmd.RustLsp({ "hover", "actions" }) end, "Hover Actions")
                map("n", "<leader>ca",  function() vim.cmd.RustLsp("codeAction")            end, "Code Action")
                map("n", "<leader>re",  function() vim.cmd.RustLsp("expandMacro")           end, "Expand Macro")
                map("n", "<leader>rr",  function() vim.cmd.RustLsp("runnables")             end, "Runnables")
                map("n", "<leader>rd",  function() vim.cmd.RustLsp("debuggables")           end, "Debuggables")
                map("n", "<leader>rt",  function() vim.cmd.RustLsp("testables")             end, "Testables")
                map("n", "<leader>rp",  function() vim.cmd.RustLsp("parentModule")          end, "Parent Module")
                map("n", "<leader>rj",  function() vim.cmd.RustLsp("joinLines")             end, "Join Lines")
                map("n", "<leader>rm",  function() vim.cmd.RustLsp("renderDiagnostic")      end, "Render Diagnostic")
                map("n", "<leader>ro",  function() vim.cmd.RustLsp("openDocs")              end, "Open Docs")
                vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
              end,
              default_settings = {
                ["rust-analyzer"] = {
                  cargo = {
                    allFeatures   = true,
                    buildScripts  = { enable = true },
                  },
                  check    = { command = "clippy" },
                  procMacro = { enable = true },
                  inlayHints = {
                    bindingModeHints       = { enable = true },
                    chainingHints          = { enable = true },
                    closingBraceHints      = { enable = true, minLines = 25 },
                    closureReturnTypeHints = { enable = "always" },
                    lifetimeElisionHints   = { enable = "skip_trivial" },
                    parameterHints         = { enable = true },
                    typeHints              = { enable = true },
                  },
                  completion = {
                    autoimport   = { enable = true },
                    autoself     = { enable = true },
                    callable     = { snippets = "fill_arguments" },
                  },
                  lens = {
                    enable           = true,
                    run              = { enable = true },
                    debug            = { enable = true },
                    implementations  = { enable = true },
                    references       = {
                      adt        = { enable = true },
                      enumVariant = { enable = true },
                      method     = { enable = true },
                      trait      = { enable = true },
                    },
                  },
                  diagnostics = {
                    enable            = true,
                    experimental      = { enable = true },
                    styleLints        = { enable = true },
                  },
                },
              },
            },
            tools = {
              hover_actions = { auto_focus = true },
              float_win_config = { border = "rounded" },
            },
          }
        end
        -- Format on save
        vim.api.nvim_create_autocmd("BufWritePre", {
          pattern  = "*.rs",
          callback = function()
            vim.lsp.buf.format({ timeout_ms = 3000, async = false })
          end,
        })
        -- Ensure diagnostics are always fully visible
        vim.diagnostic.config({
          virtual_text    = true,
          signs           = true,
          underline       = true,
          update_in_insert = false,
          severity_sort   = true,
          float = {
            border = "rounded",
            source = "always",
          },
        })
      '';
    };
  };
}
