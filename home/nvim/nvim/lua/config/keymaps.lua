-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

return {
  {
    "my-c-compile-run",
    config = function()
      vim.keymap.set('n', '<leader>r', function()
        vim.cmd('write')
        vim.cmd('!gcc % -o %:r && ./%:r')
      end, { desc = 'Compile & run C file' })
    end
  }
}
