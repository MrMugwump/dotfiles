return {
	'nvim-treesitter/nvim-treesitter',
	lazy = false,
	build = ':TSUpdate',
	opts = {
		ensure_installed = { 
			"python",
			"lua",
			"vim",
			"bash",
			"C",
			"markdown",
		},
		highlight = {
			enabled = true,
			disable = { "latex" },
		},
	},
}
