-- dependencies
local plugins = require 'user.ignite_core.ignite_plugins'

-- makes sure that toggleterm is correctly loaded
if not plugins.toggleterm then
	return
end

-- toggleterm setup
plugins.toggleterm.setup {
	-- toggleterm setup here
}
