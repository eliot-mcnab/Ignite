-- dependencies
local plugins = require 'user.ignite_core.ignite_plugins'
local notify = require 'user.ignite_core.ignite_notify'
local Notif = require 'user.ignite_core.data_structures.notification'

-- responsible for handling visuals in Ignite
local ignite_style = {}

-- styling errors
ignite_style.__error = {
	not_a_color = 'colorcolumn color must be a string',
	not_a_theme = 'Ignite theme must be a string'
}

-- default theme
ignite_style.theme = 'gruvbox'

-- ============================================================================
--								AUTOCOMMANDS
-- ============================================================================

local default_color = '#ff6666'

local function setup_colorcolumn(color)
	-- sets default color if no color was specified
	color = color or default_color

	-- makes sure that color is a string
	assert(type(color) == 'string', ignite_style.__error.not_a_color)

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

-- sets Ignite theme
-- @param theme (string): theme to run in Ignite
function ignite_style.set_theme(theme)
	-- default values
	theme = theme or ignite_style.theme

	-- makes sure function arguments are valid
	assert(type(theme) == 'string', ignite_style.__error.not_a_theme)

	-- sets the theme
	vim.cmd('colorscheme ' .. theme)

	-- updates theme
	ignite_style.theme = theme
end

-- runs setup for all style-related features
function ignite_style.setup_all(options)
	-- sets up theme
	ignite_style.set_theme(options.theme)

	-- enables autocommands
	ignite_style.setup_aucommands()
end

return ignite_style
