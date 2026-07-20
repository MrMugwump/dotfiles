vim.api.nvim_create_user_command(
    "SnipEdit",
    "UltiSnipsEdit",
    {}
)

return {
	'SirVer/ultisnips',
	config = function()
		vim.g.UltiSnipsExpandTrigger = "<tab>"
		vim.g.UltiSnipsJumpForwardTrigger = "<tab>"
		vim.g.UltiSnipsJumpBackwardTrigger = "<c-tab>"

		vim.g.UltiSnipsEditSplit = "horizontal"
	end 
}
