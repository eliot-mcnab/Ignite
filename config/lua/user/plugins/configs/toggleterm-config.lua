-- dependencies
local plugins = require 'user.ignite_core.ignite_plugins'

-- makes sure that toggleterm is correctly loaded
if not plugins.toggleterm.base then
	return
end

-- toggleterm setup
plugins.toggleterm.base.setup {
	-- no open_mapping, opening is handled by ignite_ui
	open_mapping = '**__no_mapping',
}
