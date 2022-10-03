-- this file is responsible for creating all custom vim commands

-- UI TOGGLING

-- makes sure that trouble is loaded
local trouble_loaded, _ = pcall(require, 'trouble')
if not trouble_loaded then
	return
end

-- makes sure that nvim-tree is loaded
local nvim_tree_loaded, _ = pcall(require, 'nvim-tree')
if not nvim_tree_loaded then
	return
end

-- stores in memory the state of the UI:
local is_ui_shown = false

-- toggles the ui on and off
local function toggle_ui(_)
	-- closes the UI in case it was already open 
	-- the first time the command is called
	vim.cmd [[
		TroubleClose
		NvimTreeClose
	]]

	-- opens the ui if it was previously closed
	if not is_ui_shown then
		vim.cmd [[
			Trouble
			NvimTreeOpen
		]]
	end

	-- keeps track of the current state of the UI
	is_ui_shown = not is_ui_shown
end

-- toggle UI
vim.api.nvim_create_user_command(
	'UI',
	toggle_ui,
	{
		bang = true,
		desc = 'Toggles file tree and lsp view'
	}
)

-- SESSION RESTORING

local function safe_load()

	Path = require('plenary.path')

	local path = Path:new()
	print(path:absolute())

	--print(require('lua.user.util').get_local_path())
	--require('lua.user.notifications.notif_impl').no_session()
end

-- restores session only if a local session exists
vim.api.nvim_create_user_command(
	'LoadSession',
	safe_load,
	{
		bang = true,
		desc = 'Opens local session or displays' ..
			'error notification if none was found'
	}
)
