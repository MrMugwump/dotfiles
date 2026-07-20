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
        ensure_installed = { "pyright" }
    }
    vim.lsp.config("pyright", {
        capabilities = capabilities,
    })
  end
}
