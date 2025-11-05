local g, o = vim.g, vim.o

g.mapleader = ' '
g.maplocalleader = ' '

g.have_nerd_font = false
o.number = true
o.mouse = 'a'
o.showmode = false
o.tabstop = 2
o.shiftwidth = 2

vim.schedule(function()
  o.clipboard = 'unnamedplus'
end)

o.breakindent = true
o.undofile = true
o.ignorecase = true
o.smartcase = true
o.signcolumn = 'yes'
o.updatetime = 250
o.timeoutlen = 300
o.splitright = true
o.splitbelow = true
o.list = false
o.inccommand = 'split'
o.cursorline = true
