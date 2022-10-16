-- dependencies
local plugins = require 'user.ignite_core.ignite_plugins'

-- makes sure symbols-outline is loaded
if not plugins.symbols_outline then
	return
end

-- symbols-outline setup
plugins.symbols_outline.setup {
	-- place symbols-outline settings here
}
