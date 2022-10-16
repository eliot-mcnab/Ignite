-- dependencies
local plugins = require 'user.ignite_core.ignite_plugins'

-- makes sure that ccc is loaded
if not plugins.ccc then
	return
end

-- ccc setup
plugins.ccc.setup {
	highlighter = {
		auto_enable = true
	}
}
