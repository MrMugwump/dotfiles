--
-- local s = ls.snippet
-- local sn = ls.snippet_node
-- local isn = ls.indent_snippet_node
-- local t = ls.text_node
-- local i = ls.insert_node
-- local f = ls.function_node
-- local c = ls.choice_node
-- local d = ls.dynamic_node
-- local r = ls.restore_node
-- local events = require("luasnip.util.events")
-- local ai = require("luasnip.nodes.absolute_indexer")
-- local opt = require("luasnip.nodes.optional_arg")
-- local extras = require("luasnip.extras")
-- local l = extras.lambda
-- local rep = extras.rep
-- local p = extras.partial
-- local m = extras.match
-- local n = extras.nonempty
-- local dl = extras.dynamic_lambda
-- local fmt = require("luasnip.extras.fmt").fmt
-- local fmta = require("luasnip.extras.fmt").fmta
-- local conds = require("luasnip.extras.expand_conditions")
-- local postfix = require("luasnip.extras.postfix").postfix
-- local types = require("luasnip.util.types")
-- local parse = require("luasnip.util.parser").parse_snippet
-- local ms = ls.multi_snippet
-- local k = require("luasnip.nodes.key_indexer").new_key

local snippets_dir = vim.fn.stdpath("config") .. "/luasnippets"
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
vim.keymap.set({"i","s"},"<Tab>", function()
	if require("luasnip").expandable() then
		require("luasnip").expand() 
	else if require("luasnip").jumpable(1) then 
			require("luasnip").jump(1)
		end
	end
end,{silent = true})
vim.keymap.set({"i","s"}, "<s-Tab>", function() require("luasnip").jump(-1) end, {silent = true})
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
	end
}
