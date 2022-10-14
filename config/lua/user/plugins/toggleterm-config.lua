-- dependencies
local Component = require 'user.ignite_core.data_structures.ui.ui_component'
local plugins = require 'user.ignite_core.ignite_plugins'
local ignite_ui = require 'user.ignite_core.ignite_ui'

-- makes sure that toggleterm is correctly loaded
if not plugins.toggleterm then
	return
end

-- toggleterm setup
plugins.toggleterm.setup {
	-- no open_mapping, opening is handled by ignite_ui
	open_mapping = '**__no_mapping'
}
