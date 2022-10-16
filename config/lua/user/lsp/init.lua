-- dependencies
local plugins = require 'user.ignite_core.ignite_plugins'

-- makes sure that lspconfig is loaded
if not plugins.lspconfig then
	return
end

require('user.lsp.lsp-package-setup').setup()
require('user.lsp.lsp-installer').setup()
require('user.lsp.lsp-handlers').setup()

