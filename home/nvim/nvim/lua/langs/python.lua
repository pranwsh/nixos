-- ─────────────────────────────────────────────────────────────────────────────
-- langs/python.lua
-- Everything Python-specific.  This table is read by lua/init.lua and its
-- pieces are forwarded to the appropriate core modules.
--
-- To add a new language:
--   1. Copy this file, rename it, fill in the servers / linters.
--   2. Add the binaries to langPackages in default.nix.
--   3. Add the treesitter parser to treesitterParsers in default.nix.
--   4. Rebuild with `home-manager switch`.
-- ─────────────────────────────────────────────────────────────────────────────

return {

  -- ── LSP ──────────────────────────────────────────────────────────────────
  -- Keys are lspconfig server names; values are passed straight to .setup().
  lsp = {
    servers = {
      pyright = {
        settings = {
          python = {
            analysis = {
              typeCheckingMode   = "basic",
              autoSearchPaths    = true,
              useLibraryCodeForTypes = true,
              diagnosticMode     = "workspace",
            },
          },
        },
      },
    },
  },

  -- ── Linting ──────────────────────────────────────────────────────────────
  -- nvim-lint linters_by_ft format.
  lint = {
    linters_by_ft = {
      python = { "ruff" },
    },
  },

  -- ── Notes ─────────────────────────────────────────────────────────────────
  -- Treesitter parser: add `p.python` to treesitterParsers in default.nix.
  -- Formatting:        pyright does not format; use ruff via LSP code-action,
  --                    or wire a formatter plugin (e.g. conform.nvim) here.

}
