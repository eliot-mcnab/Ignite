-- dependencies
local plugins = require 'user.ignite_core.ignite_plugins'
local notify = require 'user.ignite_core.ignite_notify'
local Notif = require 'user.ignite_core.data_structures.notification'

-- responsible for handling visuals in Ignite
local ignite_style = {}

-- styling errors
ignite_style.errors = {
	not_a_color = 'colorcolumn color must be a string'
}

-- ============================================================================
--								AUTOCOMMANDS
-- ============================================================================

local defautl_color = '#ff6666'

local function setup_colorcolumn(color)
	-- sets default color if no color was specified
	color = color or defautl_color

	-- makes sure that color is a string
	assert(type(color) == 'string', ignite_style.errors.not_a_color)

	-- sets color column color (light red)
	vim.cmd ('highlight colorcolumn ctermbg = 0 guibg = ' .. color)

	-- filetypes for which to set the colorcolumn
	local column_filetypes = {
		'c',
		'lua',
		'markdown'
	}

	-- autogroup for colorcolumn autocommand
	local augroup = vim.api.nvim_create_augroup(
		'colorcolumn_cmds',
		{ clear = true }
	)

	-- for every filetype specified in column_filetypes...
	for _, filetype in ipairs(column_filetypes) do
		-- ...creates an autocommand that will set the colorcolumn
		vim.api.nvim_create_autocmd(
			'FileType',
			{
				pattern = filetype,
				group = augroup,
				desc = 'Enables colorcolumn for ' .. filetype .. ' files',
				command = 'setlocal colorcolumn:80'
			}
		)
	end
end

-- sets up style-related autocommands
function ignite_style.setup_aucommands()
	-- enables colorcolumn 
	setup_colorcolumn()
end

-- ============================================================================
--						   	  	GENERAL STYLING
-- ============================================================================

-- runs setup for all style-related features
function ignite_style.setup_all()
	-- enables colorcolumn
	setup_colorcolumn()
end

return ignite_style
