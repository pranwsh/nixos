{...}: {
  programs.nvf.settings = {
    vim = {
      luaConfigRC.asm-indent = ''
        -- ── helpers ───────────────────────────────────────────────────────
        local function is_section(s)
          return s:match("^%.text%f[%s%c]")   or s:match("^%.text$")    or
                 s:match("^%.data%f[%s%c]")   or s:match("^%.data$")    or
                 s:match("^%.bss%f[%s%c]")    or s:match("^%.bss$")     or
                 s:match("^%.rodata%f[%s%c]") or s:match("^%.rodata$")  or
                 s:match("^%.section%s")       or
                 s:match("^%.init%f[%s%c]")   or
                 s:match("^%.fini%f[%s%c]")
        end

        local function is_label(s)
          return s:match("^[%a_][%w_%.]*:%s*$") or
                 s:match("^%.[%a_][%w_%.]*:%s*$")
        end

        _G.asm_indent = function()
          local lnum = vim.v.lnum
          local line = vim.fn.getline(lnum)
          local sw   = vim.fn.shiftwidth()
          local s    = line:match("^%s*(.-)%s*$") or ""

          if is_section(s) or is_label(s) then
            return 0
          end

          local prev     = vim.fn.prevnonblank(lnum - 1)
          local prev_raw = prev > 0 and vim.fn.getline(prev) or ""
          local ps       = prev_raw:match("^%s*(.-)%s*$") or ""

          if s == "" then
            if is_section(ps) or is_label(ps) then
              return sw
            end
            return prev > 0 and vim.fn.indent(prev) or 0
          end

          if is_section(ps) or is_label(ps) then
            return sw
          end

          return prev > 0 and vim.fn.indent(prev) or sw
        end

        -- ── apply options — deferred so we run AFTER any ftplugin ─────────
        local function apply_asm_options(buf)
          vim.schedule(function()
            if not vim.api.nvim_buf_is_valid(buf) then return end
            local ft = vim.bo[buf].filetype
            if not (ft == "asm" or ft == "s" or ft == "nasm" or ft == "gas") then
              return
            end

            vim.bo[buf].expandtab   = true
            vim.bo[buf].shiftwidth  = 2
            vim.bo[buf].tabstop     = 2
            vim.bo[buf].softtabstop = 2
            vim.bo[buf].autoindent  = true
            vim.bo[buf].smartindent = false
            vim.bo[buf].cindent     = false
            vim.bo[buf].indentexpr  = "v:lua.asm_indent()"

            vim.api.nvim_create_autocmd("BufWritePre", {
              buffer = buf,
              once   = false,
              callback = function()
                local view = vim.fn.winsaveview()
                vim.cmd("silent keepjumps normal! gg=G")
                vim.fn.winrestview(view)
              end,
            })
          end)
        end

        vim.api.nvim_create_autocmd({ "FileType", "BufEnter" }, {
          pattern  = { "*.asm", "*.s", "*.S", "*.nasm" },
          callback = function(ev)
            apply_asm_options(ev.buf)
          end,
        })

        vim.api.nvim_create_autocmd("FileType", {
          pattern  = { "asm", "s", "nasm", "gas" },
          callback = function(ev)
            apply_asm_options(ev.buf)
          end,
        })
      '';

      languages = {
        assembly = {
          enable = true;
          lsp.enable = true;
          treesitter.enable = false;
        };
      };
    };
  };
}
