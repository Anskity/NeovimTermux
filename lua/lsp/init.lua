local lsp_zero = require("lsp-zero")

local attach = function(client, buff)
	local opts = {buffer = buff}
	vim.keymap.set('n', 'K',
	'<cmd>lua vim.lsp.buf.hover()<cr>', opts)
	
	vim.keymap.set('n', 'gd',
	'<cmd>lua vim.lsp.buf.definition()<cr>',
	opts)

	vim.keymap.set('n', 'gD',
	'<cmd>lua vim.lsp.buf.declaration()<cr>'
	,opts)
end

lsp_zero.extend_lspconfig({
	  sign_text = true,
	    lsp_attach = lsp_attach,
		  capabilities = require(
		  'cmp_nvim_lsp')
		  .default_capabilities()
})

require('mason').setup({})
require('mason-lspconfig').setup({
  handlers = {
    function(server_name)
	  require('lspconfig')[server_name]
	  .setup({})
	end,
  }
})

local cmp = require('cmp')

cmp.setup({
  sources = {
    {name = 'nvim_lsp'},
  },
  snippet = {
    expand = function(args)
	  vim.snippet.expand(args.body)
    end,
  }, 
  mapping = cmp.mapping.preset.insert({}),
})
