{pkgs, ...}: {
  programs.nvf.settings = {
    vim = {
      # 1. Global LSP settings
      lsp = {
        enable = true;
        formatOnSave = true;

        # 2. Custom LSP Configuration
        lspconfig = {
          enable = true;
          sources = {
            # We inject the raw Lua setup for asm-lsp here
            asm-lsp = ''
              lspconfig.asm_lsp.setup({
                cmd = { "asm-lsp" },
                settings = {
                  ["asm-lsp"] = {
                    assembler = "gas",
                    architecture = "x86",
                    mode = "32",
                    diagnostics = true,
                  },
                },
              })
            '';
          };
        };
      };

      # 3. Ensure the LSP binary is available
      # (We must add this manually because we disabled the auto-LSP below)
      extraPackages = [pkgs.asm-lsp];

      languages = {
        enableTreesitter = true;
        enableFormat = true;

        # ... other languages ...

        # Assembly Setup
        assembly = {
          enable = true;
          treesitter.enable = true;
          # IMPORTANT: Disable the default LSP so it doesn't conflict with our custom one above
          lsp.enable = false;
        };
      };

      visuals = {
        nvim-web-devicons.enable = true;
      };
    };
  };
}
