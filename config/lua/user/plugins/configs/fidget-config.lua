-- dependencies
local plugins = require 'user.ignite_core.ignite_plugins'

-- makes sure fidget is loaded
if not plugins.fidget then
	return
end

-- fidget setup
plugins.fidget.setup {
	text = {
		spinner = 'dots'	-- changes spinner type
	}
}
