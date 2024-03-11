local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require('lazy').setup {
  spec = 'silentlamb.plugins',
  change_detection = { notify = false },
}

--  'nvim-lua/plenary.nvim',
--  'nvim-telescope/telescope.nvim'
--  'folke/tokyonight.nvim',
--  {
--    'rose-pine/neovim',
--    name = 'rose-pine',
--    config = function()
--      vim.cmd("colorscheme rose-pine")
--    end
--  },
--  {
--    'folke/trouble',
--    config = function()
--      require('trouble').setup {
--        icons = false,
--      }
--    end
--  },
--  {
--    'nvim-treesitter/nvim-treesitter',
--    build = ':TSUpdate'
--  }
