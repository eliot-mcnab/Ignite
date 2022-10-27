-- sets up null-ls

-- dependencies
local plugins = require 'user.ignite_core.ignite_plugins'

-- makes sure null-ls is loaded for lsp
if not plugins.null_ls then
	return
end

-- null-ls setup
plugins.null_ls.setup {
	sources  = {
		-- add linting sources here
		plugins.null_ls.builtins.diagnostics.norminette
	}
}
