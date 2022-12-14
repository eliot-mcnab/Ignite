-- dependencies
local plugins = require 'user.ignite_core.ignite_plugins'
local ignite_style = require 'user.ignite_core.ignite_style'

-- makes sure that the plugin is correctly loaded
if not plugins.lualine then
	return
end

-- battery support
local nvimbattery = {
	function()
		if plugins.battery then
			return plugins.battery.get_status_line()
		end
	end,
	color = { fg = 'violet' },
}

local function generate_options()
	local options_table = {}

	-- only one global lualine throughout all buffers
	options_table.globalstatus = true

	-- sets the lualine theme in accordrance with the current theme
	options_table.theme = ignite_style.theme

	return options_table
end

-- setting up lualine
plugins.lualine.setup {
	--default sections
	sections = {
		lualine_a = {'mode'},
		lualine_b = {'branch', 'diff', 'diagnostics'},
		lualine_c = {'filename'},
		lualine_x = {'encoding', 'fileformat', 'filetype', nvimbattery},
		lualine_y = {'progress'},
		lualine_z = {'location'}
	},

	-- default sections
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = {'filename'},
		lualine_x = {'location'},
		lualine_y = {},
		lualine_z = {}
	},

	--options = {
		---- only one global lualine throughout all buffers
		--globalstatus = true,

		---- lualine theme
		--theme = 'catpuccin'
	--}

	options = generate_options()
}
