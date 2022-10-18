-- dependencies
local plugins = require 'user.ignite_core.ignite_plugins'

-- makes sure that gitsigns was loaded
if not plugins.gitsigns then
	return
end

-- sets up gitsigns
plugins.gitsigns.setup(
	-- setup gitsigns here
)
