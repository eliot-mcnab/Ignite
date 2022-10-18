-- dependencies
local plugins = require 'user.ignite_core.ignite_plugins'

-- makes sure that trouble is loaded
if not plugins.trouble then
	return
end

-- setting up trouble
plugins.trouble.setup {
	-- set up trouble here
}
