--
-- NOTE: Settings options
--
-- See: :help vim.opt
--

-- Defaults
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Enable (relative) line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Where to split
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Display certain chars
vim.opt.list = true
vim.opt.listchars = {
  tab = '» ',
  trail = '·',
  nbsp = '␣',
}

vim.opt.showmode = false
vim.opt.breakindent = true

-- Always display tabs
vim.opt.showtabline = 2
