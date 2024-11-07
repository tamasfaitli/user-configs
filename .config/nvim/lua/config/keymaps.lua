-- keymap settings
--  See `:help vim.keymap.set()`

-- plugin references
local tsbuiltin = require('telescope.builtin')
local harpoon = require('harpoon')

lightTheme = 'tokyonight-day'
darkTheme = 'tokyonight-night'


-- # [G]o to places
vim.keymap.set("n", "<leader>gf", vim.cmd.Ex, {desc="[G]o to [F]ilesystem"})
-- open nvim config 
vim.keymap.set('n', '<leader>gvc', '<cmd>e ~/.config/nvim<CR>', {desc="[G]o to [V]im [C]onfig"})

-- after LSP:
-- go to definition, go to type declaration, go to "included file", 


-- # [S]earch for something
-- vim.keymap.set('n', '<leader>')
vim.keymap.set('n', '<leader>sh', tsbuiltin.help_tags, {desc='[S]earch [H]elp'})

vim.keymap.set('n', '<leader>ss', tsbuiltin.live_grep, {desc='[S]earch [S]ymbol'})
vim.keymap.set('n', '<leader>sc', function ()
    local word = vim.fn.expand('<cword>')
    tsbuiltin.grep_string({search = word})
end, {desc='[S]earch [C]urrent'})


vim.keymap.set("n", "<leader>sr", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
 {desc="[S]earch and [R]eplace"})


-- # [F]ind things
vim.keymap.set('n', '<leader>ff', tsbuiltin.find_files, {desc='[F]ind [F]iles'})
vim.keymap.set('n', '<leader>fg', tsbuiltin.git_files, {desc='[F]ind [G]it files'})
vim.keymap.set('n', '<leader>fj', tsbuiltin.jumplist, {desc='[F]ind [J]umplist'})


-- # [T]oggle things and settings
vim.keymap.set('n', '<leader>tc', function()
    if vim.g.colors_name == darkTheme then
        vim.cmd.colorscheme(lightTheme)
    else
        vim.cmd.colorscheme(darkTheme)
    end
end, {desc = '[T]oggle [C]olorscheme'})

vim.keymap.set('n', '<leader>tu', vim.cmd.UndotreeToggle, {desc='[T]oggle [U]ndotree'})

vim.keymap.set('n', '<leader>th', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, {desc="[T]oggle [H]arpoon"})
-- rest of the harpoon settings are in the others, sorry not sorry



-- # Others

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Exit terminal mode in the builtin terminal with a shortcut
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Focus -> Right' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Focus -> Down' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Focus -> Up' })
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Focus -> Left' })

-- 
vim.keymap.set('v', '<leader>d', '"_d', {desc='Delete without registers'})

-- moving up or down selected lines
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- moving up and down in command line suggestions
vim.keymap.set('c', '<Up>', '<C-p>')
vim.keymap.set('c', '<Down>', '<C-n>')

-- fix file formatting
vim.keymap.set('n', '<leader>=', 'ggVG=', {desc='Format file'})


-- harpoon settings
vim.keymap.set('n', '<leader>ha', function() harpoon:list():add() end, {desc='[H]arpoon [A]dd'})
vim.keymap.set('n', '<leader>h1', function() harpoon:list():select(1) end, {desc='[H]arpoon 1'})
vim.keymap.set('n', '<leader>h2', function() harpoon:list():select(2) end, {desc='[H]arpoon 2'})
vim.keymap.set('n', '<leader>h3', function() harpoon:list():select(3) end, {desc='[H]arpoon 3'})
vim.keymap.set('n', '<leader>h4', function() harpoon:list():select(4) end, {desc='[H]arpoon 4'})

vim.keymap.set('n', '<C-Left>', vim.cmd.bprev, {desc='Prev buffer'})
vim.keymap.set('n', '<C-Right>', vim.cmd.bnext, {desc='Next buffer'})






