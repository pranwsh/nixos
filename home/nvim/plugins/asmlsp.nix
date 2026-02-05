{pkgs, ...}: {
  programs.nvf.settings = {
    vim = {
      # 1. Standard Global Settings
      lsp.enable = true;

      languages = {
        enableTreesitter = true;

        # 2. Configure Assembly
        assembly = {
          enable = true;
          treesitter.enable = true;
          # Disable default LSP so we can define the custom one manually
          lsp.enable = false;
        };
      };

      # 3. Manually add the LSP binary
      extraPackages = [pkgs.asm-lsp];

      # 4. Inject the configuration using the correct NVF option
      # Note: luaConfigRC expects an attribute set, e.g., { name = "lua code"; }
      luaConfigRC.asm-lsp-setup = ''
        -- Define the configuration using the new vim.lsp.config API (Nvim 0.11+)
        vim.lsp.config["asm-lsp"] = {
          cmd = { "asm-lsp" },
          filetypes = { "asm", "s", "S", "vmasm" },
          root_markers = { ".git", "Makefile" },
          settings = {
            ["asm-lsp"] = {
              assembler = "gas",
              architecture = "x86",
              mode = "32",
              diagnostics = true,
            },
          },
        }

        -- Enable the server
        vim.lsp.enable("asm-lsp")
      '';

      visuals = {
        nvim-web-devicons.enable = true;
      };
    };
  };
}
