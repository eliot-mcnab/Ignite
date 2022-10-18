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

-- NvimTree integration

-- makes sure NvimTree is loaded
if not plugins.nvim_tree.base then
	return
end

-- determines the width of NvimTree buffer
-- @return (number): width of NvimTree buffer
local function get_tree_width()
	return plugins.nvim_tree.view.View.width
end

-- set offset when NvimTree opens
plugins.nvim_tree.events.subscribe('TreeOpen', function ()
	plugins.bufferline.api.set_offset(get_tree_width())
end)

-- updates offset when NvimTree resizes
plugins.nvim_tree.events.subscribe('Resize', function ()
	plugins.bufferline.api.set_offset(get_tree_width())
end)

-- removes offset when NvimTree closes
plugins.nvim_tree.events.subscribe('TreeClose', function()
	plugins.bufferline.api.set_offset(0)
end)
