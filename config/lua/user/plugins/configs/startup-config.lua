-- dependencies
local plugins = require 'user.ignite_core.ignite_plugins'

-- makes sure that startup-nvim was correctly loaded
if not plugins.startup then
	return
end

-- types
local TEXT = 'text'
local MAPPING = 'mapping'
local OLDFILES = 'oldfiles'

-- alignments
local CENTER = 'center'
local LEFT = 'left'
local RIGHT = 'right'

-- margins
local MARGIN_SMALL = 2
local MARGIN_MEDIUM = 5
local MARGIN_LARGE = 8

local headers = {
	dragon = {
		"			 ______________					",
		"       ,===:\'.,            `-._			",
		"            `:.`---.__         `-._		",
		"              `:.     `--.         `.		",
		"                \\.        `.         `.	",
		"        (,,(,    \\.         `.   ____,-`.,	",
		"     (,'     `/   \\.   ,--.___`.'			",
		" ,  ,'  ,--.  `,   \\.;'         `			",
		"  `{   {    \\  :    \\;						",
		"    \\,,'    /  /    //						",
		"    j;;    /  ,' ,-//.    ,---.      ,		",
		"    \\;'   /  ,' /  _  \\  /  _  \\   ,'/		",
		"          \\   `'  / \\  `'  / \\  `.' /		",
		"           `.___,'   `.__,'   `.__,'		"
	}
}

-- startup setup
plugins.startup.setup {
	-- startup header (logo)
	header = {
		type  = TEXT,
		oldfiles_directory = false,
		align = CENTER,
		fold_section = false,
		title = 'Header',
		margin = MARGIN_MEDIUM,
		content = headers.dragon,
		highlight = 'Statement',
		default_color = 'red',
		oldfiles_amount = 0
	},
	-- menu
	menu = {
		type = MAPPING,
		oldfiles_directory = false,
		align = CENTER,
		fold_section = false,
		title = 'Menu',
		margin = MARGIN_MEDIUM,
		content = {
			{ '  Restore Session', 'LoadSession', '<C-r>' },
			{ '  Find File', 'Telescope find_files', '<C-f>f' },
			{ '  Recent Files' , 'Telescope oldfiles', '<C-f>o' },
			{ '  Theme', 'Telescope coloscheme', '<C-f>t' }
		},
		highlight = 'String',
		default_color = '',
		oldfiles_amount = 0
	},
	-- old files
	old_files = {
		type = OLDFILES,
		oldfiles_directory = true,
		align = CENTER,
		fold_section = true,
		title = 'Old Files',
		margin = MARGIN_MEDIUM,
		content = { },
		highlight = '',
		default_color = '',
		oldfiles_amount = 5
	},
	-- sets plugin options
	options = {
		mapping_keys = true,
		cursor_column = 0.5,
		empty_lines_between_mappings = true,
		disable_statuslines = true,
		paddings = { 2, 2, 2, 2 },
    },
	-- sets plugin mappings
	mappings = {
		execute_command = "<CR>",
		open_file = "o",
		open_file_split = "<c-o>",
		open_section = "<TAB>",
		open_help = "?",
	},
	parts = { 'header', 'menu', 'old_files' }
}
