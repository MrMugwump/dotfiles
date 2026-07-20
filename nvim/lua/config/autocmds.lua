-- autosave for tex files
vim.api.nvim_create_autocmd({"InsertLeave","TextChanged"}, {
	pattern = "pattern",
	command = "command",
})
