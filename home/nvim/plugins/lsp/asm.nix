# {pkgs, ...}: {
#   programs.nvf.settings.vim = {
#     startPlugins = with pkgs.vimPlugins; [
#       nvim-lspconfig
#       nvim-treesitter.withAllGrammars
#     ];
#
#     extraPackages = with pkgs; [
#       asm-lsp
#       asmfmt
#     ];
#
#     luaConfigRC.assembly-fixed = ''
#           -- CUSTOM INDENT FUNCTION
#       _G.AsmIndent = function()
#         local line_num = vim.v.lnum
#         local line = vim.fn.getline(line_num)
#         local prev_line = vim.fn.getline(line_num - 1)
#
#         -- Don't indent labels themselves
#         if line:match("^%s*%w[%w_]*:") or line:match("^%s*%.%w+") then
#           return 0
#         end
#
#         -- Indent after labels (ends with :) or directives (starts with .)
#         if prev_line:match(":%s*$") or prev_line:match("^%s*%.%w+%s*$") then
#           return 2  -- 2 spaces of indent
#         end
#
#         -- Keep previous indent for continuation
#         local prev_indent = vim.fn.indent(line_num - 1)
#         if prev_indent > 0 then
#           return prev_indent
#         end
#
#         return 0
#       end
#
#       -- SAFE FORMAT FUNCTION
#       local function safe_format()
#         local buf = vim.api.nvim_get_current_buf()
#         local file = vim.api.nvim_buf_get_name(buf)
#         local out = vim.fn.system("asmfmt -w " .. vim.fn.shellescape(file))
#         if vim.v.shell_error == 0 then
#           vim.cmd("checktime")
#         else
#           vim.notify("asmfmt error: syntax likely invalid", vim.log.levels.WARN)
#         end
#       end
#
#       -- FORCE OVERRIDE TREESITTER INDENT
#       local function force_asm_indent()
#         vim.opt_local.cindent = false
#         vim.opt_local.smartindent = false
#         vim.opt_local.lisp = false
#         vim.opt_local.autoindent = true
#         vim.opt_local.indentexpr = "v:lua.AsmIndent()"
#       end
#
#       -- FILETYPE CONFIGURATION
#       vim.api.nvim_create_autocmd('FileType', {
#         pattern = { 'asm', 's', 'S' },
#         callback = function(args)
#           -- Set indent immediately
#           force_asm_indent()
#
#           -- Tab settings
#           vim.opt_local.expandtab = false
#           vim.opt_local.tabstop = 2
#           vim.opt_local.shiftwidth = 2
#           vim.opt_local.softtabstop = 2
#
#           vim.lsp.start({
#             name = 'asm-lsp',
#             cmd = { 'asm-lsp' },
#             root_dir = vim.fs.root(args.buf, { '.git' }) or vim.fn.getcwd(),
#           })
#
#           vim.keymap.set('n', '<leader>f', safe_format, {
#             buffer = args.buf,
#             desc = "Format ASM with asmfmt"
#           })
#
#           vim.api.nvim_create_autocmd("BufWritePost", {
#             buffer = args.buf,
#             callback = safe_format,
#           })
#         end,
#       })
#
#       -- NUCLEAR OPTION: Override treesitter again after buffer enter
#       vim.api.nvim_create_autocmd('BufEnter', {
#         pattern = { '*.asm', '*.s', '*.S' },
#         callback = function()
#           if vim.bo.filetype == 'asm' or vim.bo.filetype == 's' or vim.bo.filetype == 'S' then
#             force_asm_indent()
#           end
#         end,
#       })
#     '';
#   };
# }
{pkgs, ...}: {
  programs.nvf.settings.vim = {
    startPlugins = with pkgs.vimPlugins; [
      nvim-lspconfig
      nvim-treesitter.withAllGrammars
    ];
    extraPackages = with pkgs; [
      asm-lsp
      asmfmt
      nasm
    ];
    luaConfigRC.assembly-fixed = ''
      -- CUSTOM INDENT FUNCTION
      _G.AsmIndent = function()
        local line_num = vim.v.lnum
        local line = vim.fn.getline(line_num)
        local prev_line = vim.fn.getline(line_num - 1)
        -- Don't indent labels themselves
        if line:match("^%s*%w[%w_]*:") or line:match("^%s*%.%w+") then
          return 0
        end
        -- Indent after labels (ends with :) or directives (starts with .)
        if prev_line:match(":%s*$") or prev_line:match("^%s*%.%w+%s*$") then
          return 2  -- 2 spaces of indent
        end
        -- Keep previous indent for continuation
        local prev_indent = vim.fn.indent(line_num - 1)
        if prev_indent > 0 then
          return prev_indent
        end
        return 0
      end

      -- SAFE FORMAT FUNCTION
      local function safe_format()
        local buf = vim.api.nvim_get_current_buf()
        local file = vim.api.nvim_buf_get_name(buf)
        local out = vim.fn.system("asmfmt -w " .. vim.fn.shellescape(file))
        if vim.v.shell_error == 0 then
          vim.cmd("checktime")
        else
          vim.notify("asmfmt error: syntax likely invalid", vim.log.levels.WARN)
        end
      end

      -- FORCE OVERRIDE TREESITTER INDENT
      local function force_asm_indent()
        vim.opt_local.cindent = false
        vim.opt_local.smartindent = false
        vim.opt_local.lisp = false
        vim.opt_local.autoindent = true
        vim.opt_local.indentexpr = "v:lua.AsmIndent()"
      end

      -- FILETYPE CONFIGURATION
      vim.api.nvim_create_autocmd('FileType', {
        pattern = { 'asm', 's', 'S' },
        callback = function(args)
          -- Set indent immediately
          force_asm_indent()
          -- Tab settings
          vim.opt_local.expandtab = false
          vim.opt_local.tabstop = 2
          vim.opt_local.shiftwidth = 2
          vim.opt_local.softtabstop = 2

          -- Configure asm-lsp for AT&T syntax and x86 32-bit
          vim.lsp.start({
            name = 'asm-lsp',
            cmd = { 'asm-lsp' },
            root_dir = vim.fs.root(args.buf, { '.git' }) or vim.fn.getcwd(),
            settings = {
              ['asm-lsp'] = {
                assembler = "gas",      -- GNU Assembler (AT&T syntax)
                architecture = "x86",   -- 32-bit x86
              }
            }
          })

          vim.keymap.set('n', '<leader>f', safe_format, {
            buffer = args.buf,
            desc = "Format ASM with asmfmt"
          })
          vim.api.nvim_create_autocmd("BufWritePost", {
            buffer = args.buf,
            callback = safe_format,
          })
        end,
      })

      -- NUCLEAR OPTION: Override treesitter again after buffer enter
      vim.api.nvim_create_autocmd('BufEnter', {
        pattern = { '*.asm', '*.s', '*.S' },
        callback = function()
          if vim.bo.filetype == 'asm' or vim.bo.filetype == 's' or vim.bo.filetype == 'S' then
            force_asm_indent()
          end
        end,
      })
    '';
  };
}
