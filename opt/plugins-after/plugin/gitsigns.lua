local status, gitsigns = pcall(require, "gitsigns")
if not status then
  return
end

gitsigns.setup({
  current_line_blame = true,
  current_line_blame_opts = {
    delay = 120,
  },
})

local keymap = vim.keymap

keymap.set('n', '<leader>gr', '<cmd>:Gitsigns reset_hunk<cr>:e!<cr>', {silent = true})
keymap.set('n', '<leader>gR', '<cmd>:Gitsigns reset_buffer<cr>:e!<cr>', {silent = true})
keymap.set('n', '<leader>gE', '<cmd>:Git reset HEAD<cr>:e!<cr>', {silent = true})

keymap.set('n', '<leader>k', '<cmd>:Gitsigns prev_hunk<cr>')
keymap.set('n', '<leader>j', '<cmd>:Gitsigns next_hunk<cr>')

keymap.set('n', '<leader>gp', '<cmd>:Gitsigns preview_hunk<cr>')

keymap.set('n', '<leader>gx', '<cmd>:Gitsigns select_hunk<cr>')

keymap.set('n', '<leader>gd', '<cmd>:Gitsigns diffthis<cr>')
keymap.set('n', '<leader>gD', '<cmd>:Gitsigns diffthis HEAD~1<cr>')

keymap.set('n', '<leader>gB', '<cmd>:Gitsigns toggle_current_line_blame<cr>')
