{pkgs, ...}: {
  programs.nvf.settings = {
    vim = {
      # 1. Standard Global Settings
      lsp = {
        enable = true;
      };

      languages = {
        enableTreesitter = true;

        # 2. Configure Assembly
        assembly = {
          enable = true;
          treesitter.enable = true;
          # IMPORTANT: Disable lsp.enable here.
          # This prevents NVF from generating the deprecated `require('lspconfig')` code.
          lsp.enable = false;
        };
      };

      # 3. Manually add the LSP binary
      extraPackages = [pkgs.asm-lsp];

      # 4. Inject the new Neovim 0.11+ Native LSP Configuration
      extraLuaConfig = ''
        -- Define the configuration using the new vim.lsp.config API
        vim.lsp.config["asm-lsp"] = {
          cmd = { "asm-lsp" },
          filetypes = { "asm", "s", "S", "vmasm" },
          -- Native LSP often requires explicit root markers if not using the plugin's defaults
          root_markers = { ".git", "Makefile", "package.json" },
          settings = {
            ["asm-lsp"] = {
              assembler = "gas",
              architecture = "x86",
              mode = "32",
              diagnostics = true,
            },
          },
        }

        -- Enable the server (Standard Nvim 0.11+ method)
        vim.lsp.enable("asm-lsp")
      '';

      visuals = {
        nvim-web-devicons.enable = true;
      };
    };
  };
}
