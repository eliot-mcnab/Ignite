-- dependencies
local plugins = require 'user.ignite_core.ignite_plugins'

-- makes sure cursorline is loaded
if not plugins.cursorline then
	return
end

-- cursorline setup
plugins.cursorline.setup {
	cursorline = {
		enable = true,
		timeout = 1000,
		number = false,
	},
	cursorword = {
		enable = true,
		min_length = 3,
		hl = { underline = true },
	}
}
