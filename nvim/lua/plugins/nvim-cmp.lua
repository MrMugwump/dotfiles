return {
	"hrsh7th/nvim-cmp",
	opts = {
		snippet = {
			expand = function(args)
				vim.fn[UltiSnips#Anon"](args.body)
			end,
		},
		function() 
			local cmp = require("cmp")
			
			return {
				sources = cmp.config.sources({
					{ name = nvim_lsp },
					{ name = "ultisnips" },
				})
			}
		end 
	}
}
