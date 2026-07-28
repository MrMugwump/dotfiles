local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local opt = require("luasnip.nodes.optional_arg").new_opt
local extras = require("luasnip.extras")
local l = extras.lambda
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local conds = require("luasnip.extras.expand_conditions")
local postfix = require("luasnip.extras.postfix").postfix
local types = require("luasnip.util.types")
local parse = require("luasnip.util.parser").parse_snippet
local ms = ls.multi_snippet
local k = require("luasnip.nodes.key_indexer").new_key

local tex = require("luasnippets.tex.helpers")
local get_visual = function(_, parent)
    return sn(nil, i(1, parent.snippet.env.SELECT_RAW))
end
local display_when_not_empty = function(args,parent,string_to_show)
	if args[1][1] == " " then
		return ""
	else
		return string_to_show
	end
end
local brackets = {
	a = { "\\langle", "\\rangle" },
	A = { "Angle", "Angle" },
	b = { "brack", "brack" },
	B = { "Brack", "Brack" },
	c = { "brace", "brace" },
	m = { "|", "|" },
	p = { "(", ")" },
}

return {
	s({trig="begin",name="begin/end"},
	fmta([[
	\begin{<>}
		<>
	\end{<>}
	]],
	{i(1),i(0),rep(1)})),

	s({trig = "ln", name = "natural log"},
	fmta([[
	\ln(<>)
	]],{d(1,get_visual)}),
	{condition = tex.in_math}),

	-- there is probably a way of doing this in a better manner using a dynamic_node
	-- s({trig = "log", name = "logarithm"},
	-- fmta([[
	-- \log<><><>(<>)
	-- ]],
	-- {f(display_when_not_empty, {1}, { user_args = {"_{"}}),i(1,"base"),
	-- f(display_when_not_empty, {1}, {user_args = {"}"}}),d(2,get_visual)}),
	-- {condition = tex.in_math}),
	-- s({trig = "square", name = "square root"},
	-- fmta([[
	-- \sqrt<><><>{<>}
	-- ]],
	-- {f(display_when_not_empty, {1}, { user_args = {"["}}),i(1,"root"),
	-- f(display_when_not_empty, {1}, {user_args = {"]"}}),d(2,get_visual)}),
	-- {condition = tex.in_math}),

	-- s({trig = "sqrt", name = "square root"}, fmta([[
	-- \sqrt{<>}
	-- ]],{
	-- 	d(1,get_visual)}),{condition = tex.in_math}),
	--
	-- s(
	-- 	{trig="frac", name = "fraction"},
	-- 	fmta([[\frac{<>}{<>}]],{i(1),i(2)}),
	-- 	{condition = tex.in_math}
	-- ),

	s("imd", fmta([[$\displaystyle <>$]], {d(1,get_visual)}), {competion = tex.in_text}),
	s("trig", {
        d(1, function(args)
            if not args[1] then
                -- the arg does not exist -> provide a default.
                return sn(nil, {i(1, "asdf", {key = "ins"})})
            else
                -- This branch is only take after the dynamicNode was updated once.
                -- Now we can perform the actual "task" of this dynamicNode:
                -- replacing all occurences of "a" with "e".
                return sn(nil, {i(1, args[1][1]:gsub("a", "e"), {key = "ins"})})
            end
        end, {opt(k("ins"))})
    }),
	-- there is a way of doing this with a lot less machinery but it leaves a space.
	s("sqrt", fmta([[\sqrt<>{<>}]],
	{ d(1,function(args) -- This adds the root but deletes it if you click space and then tab. 
		if not args[1] then -- When the dynamic node is first made, nothing is there so you need to make a node
			return sn(nil, {t"[",i(1,"root",{key = "first stop"}),t"]"})
		elseif args[1][1] == " " or args[1][1] == "" then
			return sn(nil, {t""})
		else -- after the node is made, luasnip notices a change has occurred at the node marked "first stop" and runs the function again, requiring this line of text. A little silly, yes, but this is following the example given by luasnip.
			return sn(nil, {t"[",i(1,args[1][1],{key = "first stop"}),t"]"})
		end
	end, {opt(k("first stop"))}, { snippetstring_args = true }), d(2,get_visual) }
	,{condition = tex.in_math})),
	s("log", fmta([[\log<>{<>}]],
	{ d(1,function(args) -- This adds the root but deletes it if you click space and then tab. 
		if not args[1] then -- When the dynamic node is first made, nothing is there so you need to make a node
			return sn(nil, {t"_{",i(1,"base",{key = "first stop"}),t"}"})
		elseif args[1][1] == " " or args[1][1] == "" then
			return sn(nil, {t""})
		else -- after the node is made, luasnip notices a change has occurred at the node marked "first stop" and runs the function again, requiring this line of text. A little silly, yes, but this is following the example given by luasnip.
			return sn(nil, {t"_{",i(1,args[1][1],{key = "first stop"}),t"}"})
		end
	end, {opt(k("first stop"))}, { snippetstring_args = true }), d(2,get_visual) }
	,{condition = tex.in_math})),

	s("lim", {t( "\\lim_{x\\to"), i(1,"a"),t("}")}, {condition = tex.in_math}),

	s("frac", fmta([[\frac{<>}{<>}]],{i(1),i(2)}), {condition = tex.in_math}),

	s({ trig = "lr([aAbBcmp])", name = "left right", dscr = "left right delimiters", regTrig = true, hidden = true },
	fmta(
	[[
    \left<> <> \right<><>
    ]],
	{f(function(_, snip)
        cap = snip.captures[1] or 'p'
        return brackets[cap][1]
    end),
    d(1, get_visual),
    f(function(_, snip)
        cap = snip.captures[1] or 'p'
        return brackets[cap][2]
    end),
    i(0)}),
    { condition = tex.in_math}),
	-- s("begin", {
	-- 	t("\\begin{", i(1), t{"}", "","\\end{"},
	-- 	d(2, function(args)
	-- 		-- the returned snippetNode doesn't need a position; it's inserted
	-- 		-- "inside" the dynamicNode.
	-- 		return sn(nil, {
	-- 			-- jump-indices are local to each snippetNode, so restart at 1.
	-- 			i(1, args[1])
	-- 		})
	-- 	end,
	-- 	{1}),t"}"
	-- })
    -- s("trig", {
    --     t"text: ", i(1), t{"", "copy: "},
    --     d(2, function(args)
    --             -- the returned snippetNode doesn't need a position; it's inserted
    --             -- "inside" the dynamicNode.
    --             return sn(nil, {
    --                 -- jump-indices are local to each snippetNode, so restart at 1.
    --                 i(1, args[1])
    --             })
    --         end,
    --     {1})
    -- }),
	-- s({ trig='beg', name='begin/end', dscr='begin/end environment (generic)'},
	--    fmta([[
	--    \begin{<>}
	--    <>
	--    \end{<>}
	--    ]],
	--    { i(1), i(0), rep(1) }
	--    ), { condition = tex.in_text, show_condition = tex.in_text }),
}
