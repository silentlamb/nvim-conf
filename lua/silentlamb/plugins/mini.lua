return {
  'echasnovski/mini.nvim',
  config = function()
    -- Better around/inside textobjects
    --
    -- Examples:
    --  - va)   [V]isually select [A]round [(]
    --  - yinq  [Y]ank [I]nside [N]ext [']
    --  - ci'   [C]hange [I]nside [']
    require('mini.ai').setup { n_lines = 500 }

    -- Add/delete/replace surroundings
    --
    -- Examples:
    --  - saiw) [S]urround [A]dd [I]nner [W]ord [)] (paren)
    --  - sd'   [S]urround [D]elete ['] (quotes)
    --  - sr)'  [S]urround [R]replace [)] with [']
    require('mini.surround').setup()

    -- Elegant statusline
    local statusline = require 'mini.statusline'
    statusline.setup()
    statusline.section_location = function()
      return '%2l:%-2v'
    end

    -- More:  https://github.com/echasnovski/mini.nvim

    -- Popup to find things, similar to Telescope
    --
    require('mini.pick').setup()
  end,
}
