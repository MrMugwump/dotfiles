return {
	"hrsh7th/nvim-cmp",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"SirVer/ultisnips",
	},
	opts  =	function() 
		local cmp = require("cmp")
		
		return {
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "ultisnips" },
			},
			{
				{ name = "buffer"},
			}),
			snippet = {
				expand = function(args)
					vim.fn["UltiSnips#Anon"](args.body)
				end,
			},
		}
		end 
}
