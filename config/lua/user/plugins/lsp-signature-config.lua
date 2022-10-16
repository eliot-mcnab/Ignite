-- dependencies
local plugins = require 'user.ignite_core.ignite_plugins'

-- makes sure lsp-signature is loaded
if not plugins.lsp_signature then
	return
end

-- lsp-signature setup
plugins.lsp_signature.setup {
	-- icon displayed for function signature hint
	hint_prefix = ' '
}
