local M = {}

-- function M.sage_eval(args)
-- 	local expr = args[1][1]
--
-- 	local cmd = string.format("sage -c 'print(%s)'", expr)
-- 	local handle = io.popen(cmd)
-- 	if not handle then return "Error running sage, maybe not in sage env?" end
--
-- 	local result = handle:read("a")
-- 	handle:close()
--
-- 	return result
-- end

--[
-- LuaSnip Conditions
-- yanked from: evesdropper/luasnip-latex-snippets
--]


-- math / not math zones

function M.in_math()
    return vim.api.nvim_eval("vimtex#syntax#in_mathzone()") == 1
end

-- comment detection
function M.in_comment()
	return vim.fn["vimtex#syntax#in_comment"]() == 1
end

-- document class
function M.in_beamer()
	return vim.b.vimtex["documentclass"] == "beamer"
end

-- general env function
local function env(name)
	local is_inside = vim.fn["vimtex#env#is_inside"](name)
	return (is_inside[1] > 0 and is_inside[2] > 0)
end

function M.in_preamble()
	return not env("document")
end

function M.in_text()
	return env("document") and not M.in_math()
end

function M.in_tikz()
	return env("tikzpicture")
end

function M.in_bullets()
	return env("itemize") or env("enumerate")
end

function M.in_align()
	return env("align") or env("align*") or env("aligned")
end

function M.show_line_begin(line_to_cursor)
    return #line_to_cursor <= 3
end

return M
