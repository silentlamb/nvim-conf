return {
  'folke/tokyonight.nvim',
  --  'shaunsingh/moonlight.nvim',
  --  "olimorris/onedarkpro.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require('tokyonight').setup {
      transparent = true,
      styles = {
        sidebars = 'transparent',
        floats = 'transparent',
      },
    }

    vim.cmd.colorscheme 'tokyonight-night'

    -- vim.cmd.colorscheme 'onedark'
    -- vim.cmd.colorscheme 'onedark'
  end,
}
