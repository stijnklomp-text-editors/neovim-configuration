local nnoremap = require("stijn.keymap").nnoremap
local inoremap = require("stijn.keymap").inoremap
local vnoremap = require("stijn.keymap").vnoremap

vim.g.mapleader = ","

-- Use TAB instead of ENTER for autocomplete
-- inoremap <expr> <TAB> pumvisible() ? "<C-y>" : "<TAB>"
--inoremap ('<expr><TAB>', 'pumvisible() ? "<C-y>" : "<TAB>"', { expr = true })
--inoremap <expr> <TAB> pumvisible() ? "<C-y>" : "<TAB>"
--inoremap ("<expr> <TAB>", "pumvisible() ? '\<C-y>' : '\<TAB>'")

-- Move tabs
-- noremap <Leader><Left>  :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
-- noremap <Leader><Right> :execute 'silent! tabmove ' . tabpagenr()<CR>

-- Current ISO GMT date
inoremap ("<leader>date", "<cmd>:let old_tz=$TZ<CR><cmd>:let $TZ='UTC'<CR><C-R>=strftime('%Y-%m-%d T%H:%M:%SZ')<CR><cmd>:let $TZ=old_tz<CR>")

-- Lexplore and terminal setup 1
--nnoremap ("<leader>1", "<cmd>:Lexplore<CR>20<C-W><Bar><C-W>w<C-W>s<C-W>w<cmd>:term<CR>6<C-W>_<C-W>k")

-- Lexplore
nnoremap ("<leader>1", "<cmd>:Lexplore<CR>20<C-W><Bar>")

-- Show/Hide search highlights
nnoremap ("<leader>n", "<cmd>:set hlsearch!<CR>")

-- Go to next tab
nnoremap ("<leader>=", "<cmd>:+tabnext<CR>")

-- Go to previous tab
nnoremap ("<leader>-", "<cmd>:-tabnext<CR>")


-- Telescope
--local builtin = require('telescope.builtin')
--vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
--vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
--vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
--vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
