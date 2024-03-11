--
-- NOTE: This file contains basic little plugins
--
return {
  -- Git plugin so good it should be illegal
  { 'tpope/vim-fugitive' },

  -- tabstop and shiftwidth autodetection (based on other files in the workspace)
  { 'tpope/vim-sleuth' },

  -- Comment visual regions/lines
  {
    'numToStr/Comment.nvim',
    opts = {},
  },

  -- Adds signs to the gutter and utilities to manage changes
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },

  -- Highlight TODO, NOTE, etc
  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    opts = {
      signs = false,
    },
  },

  -- Visualize history of undo
  { 'mbbill/undotree' },

  -- Replace patterns with censor char
  { 'laytan/cloak.nvim' },
}
