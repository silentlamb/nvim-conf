return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',

  -- :help nvim-treesitter
  config = function()
    require('nvim-treesitter.configs').setup {
      ensure_installed = { 'bash', 'c', 'html', 'lua', 'markdown', 'vim', 'vimdoc' },
      auto_install = true,
      highlight = { enabled = true },
      indent = { enable = true },
    }

    -- NOTE: More interesting plugins to check
    --  - Incremental selection
    --  - Show your current context
    --  - Textobjects
  end,
}
