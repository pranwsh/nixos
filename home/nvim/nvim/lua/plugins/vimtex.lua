-- ==========================================
-- Complete VimTeX + Neovim LaTeX Configuration
-- ==========================================

-- 2. Compiler (latexmk)
vim.g.vimtex_compiler_method = "latexmk"
vim.g.vimtex_compiler_latexmk = {
  build_dir = "", -- "" = same dir, ".build" = out-of-source
  callback = 1,   -- Show compilation status in cmdline
  continuous = 1, -- Auto-compile on :w (save)
  executable = "latexmk",
  hooks = {},
  options = {
    "-verbose",
    "-file-line-error",
    "-synctex=1", -- Required for forward/inverse PDF search
    "-interaction=nonstopmode",
  },
}

-- 3. PDF Viewer
-- Linux: "zathura" | macOS: "skim" | Windows: "sumatra"
vim.g.vimtex_view_method = "zathura"

-- 4. Syntax & Conceal Rules
vim.g.vimtex_syntax_enabled = 1
vim.g.vimtex_syntax_conceal = {
  accents = 1,
  ligatures = 1,
  cites = 1,
  fancy = 1,
  greek = 1,
  math_bounds = 1,
  math_delimiters = 1,
  math_fracs = 1,
  math_super_sub = 1,
  math_symbols = 1,
  sections = 1,
  styles = 1,
}

-- 6. Completion & Diagnostics
vim.g.vimtex_complete_enabled = 1
vim.g.vimtex_quickfix_mode = 2 -- 0: off, 1: always, 2: errors only
vim.g.vimtex_quickfix_open_on_warning = 0

-- 7. Mappings & Indentation
vim.g.vimtex_mappings_enabled = 1
vim.g.vimtex_indent_enabled = 1
vim.g.vimtex_indent_bib = 1

-- 8. Table of Contents (TOC)
vim.g.vimtex_toc_enabled = 1
vim.g.vimtex_toc_config = {
  name = "TOC",
  layers = { "content", "todo", "include" },
  resize = 1,
  split_width = 30,
  todo_sorted = 0,
  show_help = 1,
  show_numbers = 1,
  mode = 2, -- 0: disabled, 1: manual, 2: auto-open on startup
}

-- 9. Custom Keymaps (LaTeX buffer only)
vim.api.nvim_create_autocmd("FileType", {
  pattern = "tex",
  callback = function()
    local opts = { buffer = true, noremap = true, silent = true }
    vim.keymap.set("n", "<leader>ll", "<cmd>VimtexCompile<cr>", opts)
    vim.keymap.set("n", "<leader>lv", "<cmd>VimtexView<cr>", opts)
    vim.keymap.set("n", "<leader>lt", "<cmd>VimtexTocToggle<cr>", opts)
    vim.keymap.set("n", "<leader>lc", "<cmd>VimtexClean<cr>", opts)
    vim.keymap.set("n", "<leader>li", "<cmd>VimtexInfo<cr>", opts)
  end,
})
