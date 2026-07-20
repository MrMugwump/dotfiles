return {
	"mg979/vim-visual-multi",
	init = function()
		vim.g.VM_maps = {
			["Find Under"] = "<leader>m",
			["Find Subword Under"] = "<leader>m",
		}
		-- vim.g.VM_maps['Find Under'] = '<leader>m'
		-- vim.g.VM_maps['Find Subword Under'] = '<leader>m'
	end
}
