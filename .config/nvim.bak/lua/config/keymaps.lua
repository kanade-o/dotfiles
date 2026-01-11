local keymap = vim.keymap
local opts = { noremap = true, silent = true }

keymap.set("i", "jk", "<Esc>", opts)
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
