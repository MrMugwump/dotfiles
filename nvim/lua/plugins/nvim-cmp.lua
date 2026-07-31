local ls = require("luasnip")

return {
	"hrsh7th/nvim-cmp",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-buffer",
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip"
	},
	event = { "InsertEnter", "CmdlineEnter" },
	opts  =	function()
		local cmp = require("cmp")
		
		-- print(vim.inspect(require("cmp").config.window.bordered({ border = { "╔", "═" ,"╗", "║", "╝", "═", "╚", "║" } })))

		return {
			sources = cmp.config.sources({
				{ name = "nvim_lsp", max_item_count = 10 },
				{ name = "luasnip" },
			},{
			
				{ name = "buffer"},
			}),

			window = {
				completion = {
					border = "rounded",
					winhighlight = "Normal:Normal,FloatBorder:Normal",
				},
				documentation = {
					border = "rounded",
					winhighlight = "Normal:Normal,FloatBorder:Normal",
				}

				-- border = [ "╔", "═" ,"╗", "║", "╝", "═", "╚", "║" ]
			},
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
					-- elseif cmp.visible() then 
					-- 	cmp.select_next_item()
					else
						fallback()
					end
				end,{"i","s"}),
				["<C-Space>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					else 
						fallback()
					end
				end),
				-- ["<Down>"] = cmp.mapping(function (fallback)
				-- 	if cmp.visible() then
				-- 		cmp.select_next_item()
				-- 	else
				-- 		fallback()
				-- 	end
				-- end),
				-- ["<Up>"] = cmp.mapping(function (fallback)
				-- 	if cmp.visible() then
				-- 		cmp.select_prev_item()
				-- 	else
				-- 		fallback()
				-- 	end
				-- end),
				["<s-Tab>"] = cmp.mapping(function(fallback)
					if ls.jumpable(-1) then 
						ls.jump(-1)
					elseif cmp.visible() then
						cmp.select_prev_item()
					else
						fallback()
					end
				end,{"i","s"}),
			  ['<CR>'] = cmp.mapping(function(fallback)
					if cmp.visible() and cmp.get_selected_entry() then
					  cmp.confirm()
					else
					  fallback() -- If you use vim-endwise, this fallback will behave the same as vim-endwise.
					end
				end,{"i","s"}),
				-- ["<C-s>"] = cmp.mapping(function()
				-- 		print("sdkfjslkdf")
				-- 		cmp.complete()
				-- end, { "i", "s" }),
			},
		}
		end
}
