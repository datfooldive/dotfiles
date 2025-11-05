local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

autocmd('TextYankPost', {
  group = augroup('highlight_yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

autocmd({ 'TermOpen', 'BufEnter' }, {
  pattern = 'term://*',
  command = 'startinsert',
})

autocmd('BufWritePre', {
  pattern = '*',
  command = [[%s/\s\+$//e]],
})

autocmd('BufReadPost', {
  pattern = '*',
  callback = function()
    if vim.fn.line [['"]'] > 1 and vim.fn.line [['"]'] <= vim.fn.line '$' and vim.bo.filetype ~= 'commit' then
      vim.cmd 'normal! g`"'
    end
  end,
})

autocmd('FileType', {
  pattern = { 'help', 'man', 'qf', 'lspinfo', 'checkhealth' },
  command = 'nnoremap <buffer> q :close<CR>',
})

