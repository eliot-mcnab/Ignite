-- makes sure that the plugin is correctly loaded
local lualine_loaded, lualine = pcall(require, 'lualine')
if not lualine_loaded then
	return
end

-- battery support
local nvimbattery = {
	function()
		return require("battery").get_status_line()
	end,
	color = { fg = 'violet' },
}

-- setting up lualine
lualine.setup {
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

	options = {
		-- only one global lualine throughout all buffers
		globalstatus = true,
	}
}
