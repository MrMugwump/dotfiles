local default_opts = { noremap = true, silent = true }

vim.g.mapleader = " "

vim.keymap.set("n", "<C-n>", "<cmd>Neotree toggle<CR>", defualt_opts)
