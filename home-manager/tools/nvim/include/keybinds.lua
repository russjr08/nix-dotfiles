-- Defines some keybindings for Neovim

vim.g.mapleader = " "

vim.keymap.set('n', '<F12>', ':ToggleTerm<CR>')
vim.keymap.set('n', '<F11>', ':LazyGit<CR>')

--vim.keymap.set('n', '<Leader>h', ':nohl<CR>', { silent = true })


vim.o.timeout = true
vim.o.timeoutlen = 300

-- Configure "Which-Key"
local wk = require('which-key')
wk.setup {}

wk.register({
    h = { "<cmd>nohl<CR>", "Dismiss Highlighting" },
    [ "<F11>" ] = { "<cmd>LazyGit<CR>", "LazyGit" },
    [ "<F12>" ] = { "<cmd>ToggleTerm", "Open Terminal" },
    t = {
	name = "Tabs",
	p = { "<cmd>BufferPrevious<CR>", "Previous Tab" },
	n = { "<cmd>BufferNext<CR>", "Next Tab" },
	c = { "<cmd>BufferClose<CR>", "Close Tab" },
    },

}, { prefix = "<leader>" })

