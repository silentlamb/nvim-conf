-- Most remaps comes from plugins so for defitinion go to their setup() function.
--
-- Here let's add some customization to make nvim even more powerful.
--

-- common opts
local opts = { noremaps = true, silent = true }

local map = function(mode, keys, command, desc)
  vim.keymap.set(mode, keys, command, vim.list_extend({ desc = desc }, opts))
end

-- Tab management
map('n', '<Leader>te', '<cmd>tabedit<CR>', '[T]ab [E]dit')
map('n', '<Leader>tn', '<cmd>tabnext<CR>', '[T]ab [N]ext')
map('n', '<Leader>tp', '<cmd>tabprev<CR>', '[T]ab [P]rev')
map('n', '<Leader>tc', '<cmd>tabclose<CR>', '[T]ab [C]lose')
-- Just to make life easier
map('n', '<Tab>', '<cmd>tabnext<CR>', 'Switch to next tab')
map('n', '<S-Tab>', '<cmd>tabprev<CR>', 'Switch to prev tab')
