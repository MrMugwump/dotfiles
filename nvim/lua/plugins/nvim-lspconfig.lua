return { "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
	"hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)


    require('mason').setup()
    local mason_lspconfig = require 'mason-lspconfig'
    mason_lspconfig.setup {
        ensure_installed = {
			"pyright",
			"lua_ls",
			"texlab",
		}
    }
		-- local capabilities = require('cmp_nvim_lsp').default_capabilities()
		vim.lsp.config("lua_ls", {
			capabilities = capabilities,
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
					workspace = { checkThirdParty = false, },
				}
			}
		})
		vim.lsp.config("pyright", {
			capabilities = capabilities,
		})
		-- vim.lsp.config("texlab",{
		-- 	settings = {
		-- 		texlab = {
		-- 			build = {
		-- 				auxDirectory = "./aux",
		-- 			},
		-- 		}, 
		-- 	}	
		-- })
  end
}
