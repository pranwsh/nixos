-- vim.g.rustaceanvim = {
--
--   -- ─── Tool / UI options ───────────────────────────────────────────────────
--   tools = {
--     hover_actions = {
--       auto_focus = true,           -- focus the hover window automatically
--       replace_builtin_hover = true -- K uses rustaceanvim hover, not vim.lsp.buf.hover
--     },
--     float_win_config = {
--       border = "rounded",
--       max_width = 100,
--     },
--     -- inline hints rendered via inlay_hints (nvim 0.10+ native)
--     inlay_hints = {
--       auto = true,                 -- enable on attach automatically
--       only_current_line = false,   -- show for all lines, not just cursor line
--       show_parameter_hints = true, -- fn call param names
--       parameter_hints_prefix = "<- ",
--       other_hints_prefix = "=> ",  -- for type hints, chaining hints etc.
--       max_len_align = false,
--       max_len_align_padding = 1,
--       right_align = false,
--       right_align_padding = 7,
--       highlight = "Comment", -- link to any highlight group you like
--     },
--     on_initialized = function()
--       -- refresh inlay hints whenever we save or leave insert
--       vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
--         pattern = { "*.rs" },
--         callback = function()
--           vim.lsp.inlay_hint.enable(true) -- nvim 0.10+ API
--         end,
--       })
--     end,
--   },
--
--   -- ─── rust-analyzer server config ─────────────────────────────────────────
--   server = {
--     on_attach = function(client, bufnr)
--       local map = function(mode, lhs, rhs, desc)
--         vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
--       end
--
--       -- ── Hover ───────────────────────────────────────────────────────────
--       -- Override K with rustaceanvim's richer hover (shows actions too)
--       map("n", "K", function() vim.cmd.RustLsp("hover", "actions") end, "Rust hover actions")
--       map("n", "<leader>rk", function() vim.cmd.RustLsp("hover", "range") end, "Rust hover range")
--
--       -- ── Code actions / runnables ────────────────────────────────────────
--       map("n", "<leader>ra", function() vim.cmd.RustLsp("codeAction") end, "Rust code action")
--       map("n", "<leader>rr", function() vim.cmd.RustLsp("runnables") end, "Rust runnables")
--       map("n", "<leader>rd", function() vim.cmd.RustLsp("debuggables") end, "Rust debuggables")
--       map("n", "<leader>rt", function() vim.cmd.RustLsp("testables") end, "Rust testables")
--       map("n", "<leader>re", function() vim.cmd.RustLsp("expandMacro") end, "Rust expand macro")
--       map("n", "<leader>rc", function() vim.cmd.RustLsp("openCargo") end, "Open Cargo.toml")
--       map("n", "<leader>rp", function() vim.cmd.RustLsp("parentModule") end, "Go to parent module")
--       map("n", "<leader>rg", function() vim.cmd.RustLsp("crateGraph") end, "Crate graph")
--
--       -- ── Structural navigation ───────────────────────────────────────────
--       map("n", "]]", function() vim.cmd.RustLsp("moveItem", "down") end, "Move item down")
--       map("n", "[[", function() vim.cmd.RustLsp("moveItem", "up") end, "Move item up")
--       map("n", "<leader>rj", function() vim.cmd.RustLsp("joinLines") end, "Rust join lines")
--
--       -- ── Standard LSP ───────────────────────────────────────────────────
--       map("n", "gd", vim.lsp.buf.definition, "Go to definition")
--       map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
--       map("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
--       map("n", "gr", vim.lsp.buf.references, "References")
--       map("n", "gy", vim.lsp.buf.type_definition, "Type definition")
--       map("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
--       map("n", "<leader>rf", function() vim.lsp.buf.format({ async = true }) end, "Format buffer")
--
--       -- ── Diagnostics shown on CursorHold (normal mode) ──────────────────
--       map("n", "<leader>rl", vim.diagnostic.open_float, "Line diagnostics")
--       map("n", "[d", vim.diagnostic.goto_prev, "Prev diagnostic")
--       map("n", "]d", vim.diagnostic.goto_next, "Next diagnostic")
--
--       -- Show diagnostics float automatically in normal mode after idle
--       vim.api.nvim_create_autocmd("CursorHold", {
--         buffer = bufnr,
--         callback = function()
--           vim.diagnostic.open_float(nil, {
--             focusable = false,
--             close_events = { "CursorMoved", "InsertEnter", "BufLeave" },
--             border = "rounded",
--             source = "always", -- always show the source (e.g. "rust-analyzer")
--             prefix = " ",
--             scope = "cursor",  -- only show diagnostic under cursor, not whole line
--           })
--         end,
--       })
--
--       -- Turn on inlay hints for this buffer
--       if vim.lsp.inlay_hint then
--         vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
--       end
--     end,
--
--     -- How long after cursor stops moving before CursorHold fires (ms)
--     -- Set low so diagnostics feel "on change" responsive
--     -- (this is a global vim option, set here for co-location)
--     -- vim.o.updatetime is set below outside this table
--
--     default_settings = {
--       ["rust-analyzer"] = {
--
--         -- ── Cargo ─────────────────────────────────────────────────────────
--         cargo = {
--           allFeatures = true,
--           loadOutDirsFromCheck = true,
--           runBuildScripts = true,
--         },
--
--         -- ── Check / diagnostics ───────────────────────────────────────────
--         checkOnSave = {
--           enable = true,
--           command = "clippy",
--           extraArgs = { "--no-deps" },
--         },
--         diagnostics = {
--           enable = true,
--           experimental = { enable = true }, -- extra experimental lints
--           styleLints = { enable = true },
--         },
--
--         -- ── Inlay hints (server-side declarations) ────────────────────────
--         inlayHints = {
--           bindingModeHints          = { enable = true },
--           chainingHints             = { enable = true },
--           -- closingBraceHints         = { enable = true, minLines = 10 },
--           -- closureReturnTypeHints    = { enable = "always" },  -- "never"|"with_block"|"always"
--           -- discriminantHints         = { enable = "always" },
--           expressionAdjustmentHints = { enable = "always" },
--           implicitDrops             = { enable = true },
--           -- lifetimeElisionHints      = { enable = "always", useParameterNames = true },
--           maxLength                 = 30, -- truncate long hints
--           parameterHints            = { enable = true },
--           -- rangeExclusiveHints       = { enable = true },
--           renderColons              = true,
--           reborrowHints             = { enable = "always" },
--           typeHints                 = {
--             enable               = true,
--             -- hideClosureInitialization = false,
--             hideNamedConstructor = false,
--           },
--         },
--
--         -- ── Proc macros ───────────────────────────────────────────────────
--         procMacro = {
--           enable = true,
--           ignored = {
--             ["async-trait"] = { "async_trait" },
--             ["napi-derive"] = { "napi" },
--           },
--         },
--
--         -- ── Completion ────────────────────────────────────────────────────
--         completion = {
--           autoimport      = { enable = true },
--           autoself        = { enable = true },
--           postfix         = { enable = true },
--           privateEditable = { enable = true },
--         },
--
--         -- ── Lens (code lens for run/debug/test above fns) ─────────────────
--         lens = {
--           enable          = true,
--           run             = { enable = true },
--           debug           = { enable = true },
--           implementations = { enable = true },
--           references      = {
--             adt         = { enable = true },
--             enumVariant = { enable = true },
--             method      = { enable = true },
--             trait       = { enable = true },
--           },
--         },
--
--         -- ── Hover ─────────────────────────────────────────────────────────
--         hover = {
--           actions       = {
--             enable          = true,
--             run             = { enable = true },
--             debug           = { enable = true },
--             goto_type_def   = { enable = true },
--             implementations = { enable = true },
--             references      = { enable = true },
--           },
--           documentation = { enable = true },
--           links         = { enable = true },
--           memoryLayout  = {
--             enable    = true,
--             alignment = "hexadecimal",
--             niches    = true,
--             offset    = "hexadecimal",
--             size      = "both",
--           },
--         },
--
--         -- ── Semantic tokens (richer highlight groups) ─────────────────────
--         semanticHighlighting = {
--           operator = { specialization = { enable = true } },
--           punctuation = {
--             enable   = true,
--             separate = {
--               macro = { bang = true },
--             },
--           },
--           strings = { enable = true },
--         },
--
--         imports = {
--           granularity = { group = "module" },
--           prefix = "self",
--         },
--
--       },
--     },
--   },
--
--   -- ─── DAP (debugging) integration ─────────────────────────────────────────
--   dap = {
--     adapter = {
--       type    = "executable",
--       command = "lldb-vscode", -- or "codelldb" if you have it via mason/nix
--       name    = "lldb",
--     },
--   },
-- }
--
-- -- CursorHold fires after this many ms of no cursor movement in normal mode.
-- -- 300–500 ms feels snappy without being annoying.
-- vim.o.updatetime = 300
--
vim.g.rustaceanvim = {

  -- ─── Tool / UI options ───────────────────────────────────────────────────
  tools = {
    hover_actions = {
      auto_focus = true,           -- focus the hover window automatically
      replace_builtin_hover = true -- K uses rustaceanvim hover, not vim.lsp.buf.hover
    },
    float_win_config = {
      border = "rounded",
      max_width = 100,
    },
    -- inline hints rendered via inlay_hints (nvim 0.10+ native)
    inlay_hints = {
      auto = true,                 -- enable on attach automatically
      only_current_line = false,   -- show for all lines, not just cursor line
      show_parameter_hints = true, -- fn call param names
      parameter_hints_prefix = "<- ",
      other_hints_prefix = "=> ",  -- for type hints, chaining hints etc.
      max_len_align = false,
      max_len_align_padding = 1,
      right_align = false,
      right_align_padding = 7,
      highlight = "Comment", -- link to any highlight group you like
    },
    on_initialized = function()
      -- refresh inlay hints whenever we save or leave insert
      vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
        pattern = { "*.rs" },
        callback = function()
          vim.lsp.inlay_hint.enable(true) -- nvim 0.10+ API
        end,
      })
    end,
  },

  -- ─── rust-analyzer server config ─────────────────────────────────────────
  server = {
    on_attach = function(client, bufnr)
      local map = function(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
      end

      -- ── Hover ───────────────────────────────────────────────────────────
      -- Override K with rustaceanvim's richer hover (shows actions too)
      map("n", "K", function() vim.cmd.RustLsp("hover", "actions") end, "Rust hover actions")
      map("n", "<leader>rk", function() vim.cmd.RustLsp("hover", "range") end, "Rust hover range")

      -- ── Code actions / runnables ────────────────────────────────────────
      map("n", "<leader>ra", function() vim.cmd.RustLsp("codeAction") end, "Rust code action")
      map("n", "<leader>rr", function() vim.cmd.RustLsp("runnables") end, "Rust runnables")
      map("n", "<leader>rd", function() vim.cmd.RustLsp("debuggables") end, "Rust debuggables")
      map("n", "<leader>rt", function() vim.cmd.RustLsp("testables") end, "Rust testables")
      map("n", "<leader>re", function() vim.cmd.RustLsp("expandMacro") end, "Rust expand macro")
      map("n", "<leader>rc", function() vim.cmd.RustLsp("openCargo") end, "Open Cargo.toml")
      map("n", "<leader>rp", function() vim.cmd.RustLsp("parentModule") end, "Go to parent module")
      map("n", "<leader>rg", function() vim.cmd.RustLsp("crateGraph") end, "Crate graph")

      -- ── Structural navigation ───────────────────────────────────────────
      map("n", "]]", function() vim.cmd.RustLsp("moveItem", "down") end, "Move item down")
      map("n", "[[", function() vim.cmd.RustLsp("moveItem", "up") end, "Move item up")
      map("n", "<leader>rj", function() vim.cmd.RustLsp("joinLines") end, "Rust join lines")

      -- ── Standard LSP ───────────────────────────────────────────────────
      map("n", "gd", vim.lsp.buf.definition, "Go to definition")
      map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
      map("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
      map("n", "gr", vim.lsp.buf.references, "References")
      map("n", "gy", vim.lsp.buf.type_definition, "Type definition")
      map("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
      map("n", "<leader>rf", function() vim.lsp.buf.format({ async = true }) end, "Format buffer")

      -- ── Diagnostics shown on CursorHold (normal mode) ──────────────────
      map("n", "<leader>rl", vim.diagnostic.open_float, "Line diagnostics")
      map("n", "[d", vim.diagnostic.goto_prev, "Prev diagnostic")
      map("n", "]d", vim.diagnostic.goto_next, "Next diagnostic")

      -- Show diagnostics float automatically in normal mode after idle
      vim.api.nvim_create_autocmd("CursorHold", {
        buffer = bufnr,
        callback = function()
          vim.diagnostic.open_float(nil, {
            focusable = false,
            close_events = { "CursorMoved", "InsertEnter", "BufLeave" },
            border = "rounded",
            source = "always", -- always show the source (e.g. "rust-analyzer")
            prefix = " ",
            scope = "cursor",  -- only show diagnostic under cursor, not whole line
          })
        end,
      })

      -- Turn on inlay hints for this buffer
      if vim.lsp.inlay_hint then
        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
      end
    end,

    -- How long after cursor stops moving before CursorHold fires (ms)
    -- Set low so diagnostics feel "on change" responsive
    -- (this is a global vim option, set here for co-location)
    -- vim.o.updatetime is set below outside this table

    default_settings = {
      ["rust-analyzer"] = {

        -- ── Cargo ─────────────────────────────────────────────────────────
        cargo = {
          allFeatures = true,
          loadOutDirsFromCheck = true,
          runBuildScripts = true,
        },

        -- ── Check / diagnostics ───────────────────────────────────────────
        checkOnSave = {
          enable = true,
          command = "clippy",
          extraArgs = { "--no-deps" },
        },
        diagnostics = {
          enable = true,
          experimental = { enable = true }, -- extra experimental lints
          styleLints = { enable = true },
        },

        -- ── Inlay hints (server-side declarations) ────────────────────────
        -- ONLY TYPE HINTS AND PARAMETER HINTS ENABLED
        inlayHints = {
          -- Type hints for variable bindings (let x: i32 = ...)
          typeHints = {
            enable = true,
            hideClosureInitialization = true, -- hide noisy closure types
            hideNamedConstructor = false,     -- show struct literal types
          },

          -- Parameter hints for function calls (foo(/* x: */ 42))
          parameterHints = { enable = true },

          -- Show return type hints on closures (only multi-line blocks)
          closureReturnTypeHints = { enable = "with_block" },

          -- Everything below is DISABLED
          bindingModeHints = { enable = false },
          chainingHints = { enable = false },
          closingBraceHints = { enable = false },
          discriminantHints = { enable = false },
          expressionAdjustmentHints = { enable = "never" },
          implicitDrops = { enable = false },
          lifetimeElisionHints = { enable = "never" },
          rangeExclusiveHints = { enable = false },
          reborrowHints = { enable = "never" },
          renderColons = true,
          maxLength = 30,
        },

        -- ── Proc macros ───────────────────────────────────────────────────
        procMacro = {
          enable = true,
          ignored = {
            ["async-trait"] = { "async_trait" },
            ["napi-derive"] = { "napi" },
          },
        },

        -- ── Completion ────────────────────────────────────────────────────
        completion = {
          autoimport      = { enable = true },
          autoself        = { enable = true },
          postfix         = { enable = true },
          privateEditable = { enable = true },
        },

        -- ── Lens (code lens for run/debug/test above fns) ─────────────────
        lens = {
          enable          = true,
          run             = { enable = true },
          debug           = { enable = true },
          implementations = { enable = true },
          references      = {
            adt         = { enable = true },
            enumVariant = { enable = true },
            method      = { enable = true },
            trait       = { enable = true },
          },
        },

        -- ── Hover ─────────────────────────────────────────────────────────
        hover = {
          actions       = {
            enable          = true,
            run             = { enable = true },
            debug           = { enable = true },
            goto_type_def   = { enable = true },
            implementations = { enable = true },
            references      = { enable = true },
          },
          documentation = { enable = true },
          links         = { enable = true },
          memoryLayout  = {
            enable    = true,
            alignment = "hexadecimal",
            niches    = true,
            offset    = "hexadecimal",
            size      = "both",
          },
        },

        -- ── Semantic tokens (richer highlight groups) ─────────────────────
        semanticHighlighting = {
          operator = { specialization = { enable = true } },
          punctuation = {
            enable   = true,
            separate = {
              macro = { bang = true },
            },
          },
          strings = { enable = true },
        },

        imports = {
          granularity = { group = "module" },
          prefix = "self",
        },

      },
    },
  },

  -- ─── DAP (debugging) integration ─────────────────────────────────────────
  dap = {
    adapter = {
      type    = "executable",
      command = "lldb-vscode", -- or "codelldb" if you have it via mason/nix
      name    = "lldb",
    },
  },
}

-- CursorHold fires after this many ms of no cursor movement in normal mode.
-- 300–500 ms feels snappy without being annoying.
vim.o.updatetime = 300
