-- makes sure that lspconfig is loaded
local lsp_loaded, _ = pcall(require, 'lspconfig') 
if not lsp_loaded then
	return
end

require('user.lsp.lsp-package-setup').setup()
require('user.lsp.lsp-installer')
require('user.lsp.handlers').setup()

