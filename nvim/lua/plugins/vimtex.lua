return {
  "lervag/vimtex",
  lazy = false,     -- we don't want to lazy load VimTeX
  -- tag = "v2.15", -- uncomment to pin to a specific release
  init = function()
    -- VimTeX configuration goes here, e.g.
    vim.g.vimtex_view_method = "zathura"
	-- vim.g.vimtex_compiler_latexmk = {'aux_dir': {_ -> expand("%:t:r")}}
	-- vim.g.vimtex_compiler_latexmk = {
	-- 	aux_dir = function()
	-- 		return "aux"
	-- 	end,
	-- out_dir = function()
	-- 	return "out/" .. vim.fn.expand("%:t:r")
	-- end,
	-- }
	vim.g.vimtex_quickfix_mode = 0
	vim.g.tex_flavor = "latex"
	vim.opt.conceallevel = 2
	vim.g.vimtex_syntax_conceal = {
		spacing = 0,
		cites = 0,
		math_bounds = 0,
		math_fracs = 0,
	}
  end
}
