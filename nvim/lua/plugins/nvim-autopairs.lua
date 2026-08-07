return {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    -- use opts = {} for passing setup options
    -- this is equivalent to setup({}) function
	opts = {
      disable_filetype = { "TelescopePrompt" , "vim" },
	},
    config = function(opts)
		local Rule = require('nvim-autopairs.rule')
		local npairs = require('nvim-autopairs')

		npairs.setup(opts)

		local brace_rule = npairs.get_rules("{")[1]

		npairs.add_rule(Rule("$","$","tex")
			:with_pair(brace_rule.pair)
			:with_move(brace_rule.move)
			:with_del(brace_rule.del)
		)

		-- npairs.add_rule(Rule("`","`","-tex"))
		--
		-- npairs.add_rule(Rule("``","\"","tex") -- Doesn't work because Rule happens before text is inserted.
		-- 	:with_pair(brace_rule.pair)
		-- 	:with_move(brace_rule.move)
		-- 	:with_del(brace_rule.del)
		-- )
	end,
}
