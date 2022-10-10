-- dependencies
local plugins = require 'user.ignite_core.ignite_plugins'

-- makes sure that barbar is loaded
if not plugins.barbar then
	return
end

-- barbar setup
plugins.barbar.setup {
	-- sets icon characters
	icon_separator_active = '▎',
	icon_separator_inactive = '▎',
	icon_close_tab = '',
	icon_close_tab_modified = '●',
	icon_pinned = '車',
}
