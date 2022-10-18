-- dependencies
local plugins = require 'user.ignite_core.ignite_plugins'

-- makes sure that notify was loaded correctly
if not plugins.notify then
	return
end

-- sets up notify
plugins.notify.setup {
	stages = "slide",
	background_colour = "#000000"
}
