vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4

vim.opt.relativenumber = true
vim.opt.number = true

vim.api.nvim_create_user_command(
    "Dotfiles",
    "cd ~/dotfiles/",
    {}
)

-- vim.api.nvim_set_hl(0, "NormalFloat", { link = "Normal"})
