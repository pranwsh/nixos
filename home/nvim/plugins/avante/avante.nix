{pkgs, ...}: {
  programs.nvf.settings.vim = {
    # Add avante dependencies
    luaPackages = with pkgs.vimPlugins; [
      plenary-nvim
      nui-nvim
    ];

    # Avante.nvim configuration
    extraPlugins = with pkgs.vimPlugins; {
      avante-nvim = {
        package = avante-nvim;
        setup = ''
          require('avante').setup({
            provider = "openai",
            openai = {
              endpoint = "http://127.0.0.1:8080/v1",
              model = "qwen2.5-coder-7b-instruct",
              api_key_name = "dummy",
              temperature = 0.7,
              max_tokens = 4096,
            },
            behaviour = {
              auto_suggestions = true,
              auto_set_highlight_group = true,
              auto_set_keymaps = true,
            },
            mappings = {
              ask = "<leader>aa",
              edit = "<leader>ae",
              refresh = "<leader>ar",
              toggle = "<leader>at",
              diff = {
                ours = "co",
                theirs = "ct",
                both = "cb",
                next = "]x",
                prev = "[x",
              },
            },
            hints = {
              enabled = true,
            },
            windows = {
              wrap = true,
              width = 30,
              sidebar_header = {
                align = "center",
                rounded = true,
              },
            },
            highlights = {
              diff = {
                current = "DiffText",
                incoming = "DiffAdd",
              },
            },
          })
        '';
      };

      # Optional: render-markdown for better display
      render-markdown-nvim = {
        package = render-markdown-nvim;
        setup = "require('render-markdown').setup({})";
      };

      # Optional: dressing for better UI
      dressing-nvim = {
        package = dressing-nvim;
        setup = "require('dressing').setup({})";
      };
    };

    # Key mappings
    maps = {
      normal = {
        "<leader>aa" = {
          action = ":AvanteAsk<CR>";
          desc = "Avante: Ask AI";
        };
        "<leader>ae" = {
          action = ":AvanteEdit<CR>";
          desc = "Avante: Edit with AI";
        };
        "<leader>ar" = {
          action = ":AvanteRefresh<CR>";
          desc = "Avante: Refresh";
        };
        "<leader>at" = {
          action = ":AvanteToggle<CR>";
          desc = "Avante: Toggle";
        };
      };
      visual = {
        "<leader>aa" = {
          action = ":AvanteAsk<CR>";
          desc = "Avante: Ask AI about selection";
        };
      };
    };
  };
}
