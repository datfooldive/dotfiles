if vim.g.vscode then
  local vscode = require 'vscode'
  vim.keymap.set({ 'n', 'x', 'i' }, '<C-d>', function()
    vscode.with_insert(function()
      vscode.action 'editor.action.addSelectionToNextFindMatch'
    end)
  end)
  vim.keymap.set({ 'n', 'x', 'i' }, '<C-Up>', function()
    vscode.action 'editor.action.moveLinesUpAction'
  end)

  vim.keymap.set({ 'n', 'x', 'i' }, '<C-Down>', function()
    vscode.action 'editor.action.moveLinesDownAction'
  end)

  vim.keymap.set({ 'n', 'x' }, '<leader>ff', function()
    vscode.action 'workbench.action.quickOpen'
  end)
end

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('t', '<Esc><Esc>', '<C-\'><C-n>', { desc = 'Exit terminal mode' })

vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.keymap.set('n', '<C-a>', 'ggVG')
vim.keymap.set('i', '<C-a>', '<Esc>ggVG')
vim.keymap.set('v', '<C-a>', 'ggVG')
