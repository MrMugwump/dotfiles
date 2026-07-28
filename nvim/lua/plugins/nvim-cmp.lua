local ls = require("luasnip")
return {
	"hrsh7th/nvim-cmp",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-buffer",
		"L3MON4D3/LuaSnip",
	},
	opts  =	function()
		local cmp = require("cmp")

		return {
			sources = cmp.config.sources({
				{ name = "nvim_lsp", max_item_count = 10 },
				{ name = "luasnip" },
			},
			{
				{ name = "buffer"},
			}),
			snippet = {
				expand = function(args)
					-- vim.fn["UltiSnips#Anon"](args.body)
					require('luasnip').lsp_expand(args.body)
				end,
			},
			mapping = {
				["<Tab>"] = cmp.mapping(function(fallback)
					if ls.expand_or_jumpable() then 
						ls.expand_or_jump()
					elseif cmp.visible() then 
						cmp.select_next_item()
					else
						fallback()
					end
				end,{"i","s"}),
				["<Down>"] = cmp.mapping(function (fallback)
					if cmp.visible() then
						cmp.select_next_item()
					else
						fallback()
					end
				end),
				["<Up>"] = cmp.mapping(function (fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					else
						fallback()
					end
				end),
				["<s-Tab>"] = cmp.mapping(function(fallback)
					if ls.jumpable(-1) then 
						ls.jump(-1)
					elseif cmp.visible() then
						cmp.select_prev_item()
					else
						fallback()
					end
				end,{"i","s"}),
			  ['<CR>'] = function(fallback)
					if cmp.visible() then
					  cmp.confirm()
					else
					  fallback() -- If you use vim-endwise, this fallback will behave the same as vim-endwise.
					end
				end
				-- ["<C-s>"] = cmp.mapping(function()
				-- 		print("sdkfjslkdf")
				-- 		cmp.complete()
				-- end, { "i", "s" }),
			},
		}
		end
}
