local default_opts = { noremap = true, silent = true }

vim.keymap.set("n", "<C-n>", "<cmd>Neotree toggle<CR>", default_opts)

vim.keymap.set("n", "<leader>o", "o<Esc>")
vim.keymap.set("n", "<leader>O", "O<Esc>")

-- LuaSnip keymaps --
-- vim.keymap.set({"i","s"},"<Tab>", function(callback)
-- 	if require("luasnip").expand_or_jumpable() then
-- 		require("luasnip").expand_or_jump()
-- 	else
-- 		return "<Tab>" -- functions like a normal tab
-- 	end
-- end,{ expr = true})
--
-- vim.keymap.set({"i","s"}, "<s-Tab>", function() require("luasnip").jump(-1) end, {silent = true})
vim.keymap.set({ "i", "s" }, "<C-n>", function()
	require("luasnip").change_choice(1)
end, {silent = true})
-- vim.api.nvim_set_keymap("s", "<C-n>", "<Plug>luasnip-next-choice", {})
vim.keymap.set({ "i", "s" }, "<C-p>", function()
	require("luasnip").change_choice(-1)
end, {silent = true})
-- vim.api.nvim_set_keymap("s", "<C-p>", "<Plug>luasnip-prev-choice", {})


vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, {silent=true})
-- vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float)

-- ripped from telescopes's readme
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
-- vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

