-- ============================================================================
-- 								SETS UP NULL-LS
-- ============================================================================

-- dependencies
local plugins = require 'user.ignite_core.ignite_plugins'

-- makes sure null-ls is loaded for lsp
if not plugins.null_ls then
	return
end

local norminette = require 'user.linting.linters.norminette'

-- null-ls setup
plugins.null_ls.setup {
	debounce = 10
}
