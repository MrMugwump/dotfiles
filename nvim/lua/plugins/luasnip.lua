local snippets_dir = vim.fn.stdpath("config") .. "/lua/luasnippets"
local function edit_snippets()
	require("luasnip.loaders").edit_snippet_files({
		extend = function(ft, paths)
			if paths == 0 then
			  return {
				{ string.format("%s/%s.lua", snippets_dir, ft) }
			  }
			end

			return {}
		end,
		edit = function(file)
			vim.cmd("vsplit" .. file)
		end,
	})
end
vim.api.nvim_create_user_command(
	"LuaSnipEdit",
	edit_snippets,
	{}
)

-- vim.keymap.set({"i","s"}, "<Tab>", function() require("luasnip").expand() end, {silent = false})
-- vim.keymap.set({"i","s"}, "<s-Tab>", function() require("luasnip").jump(-1) end, {silent = true})
return {
	"L3MON4D3/LuaSnip",
	-- follow latest release.
	version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
	-- install jsregexp (optional!).
	build = "make install_jsregexp",
	config = function()
		require("luasnip.loaders.from_lua").lazy_load({
			paths = snippets_dir,
		})
		require("luasnip").config.set_config({
			store_selection_keys = "<Tab>"
		})
		-- require("luasnip").config.setup({
		-- 	history = true,
		-- 	region_check_events = "InsertEnter",
		-- 	delete_check_events = "TextChanged,InsertLeave",
		-- })
	end
}
