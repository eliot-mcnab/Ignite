-- dependencies
local plugins = require 'user.ignite_core.ignite_plugins'

-- makes sure that treesitter is properly loaded
if not plugins.treesitter then
	return
end

plugins.treesitter.setup {
	-- the language parsers to be installed
	ensure_installed = {
		"c",
		"lua",
		"markdown"
	},

	sync_isntall = false,					-- asychroneous install (faster)
	auto_install = true,					-- auto-installs missing parsers
	ignore_install = { "" },				-- language parsers not to install

	highlight = {
		enable = true,		-- enables highlighting
		disable = { "" },	-- languages on which highlighting will be disabled

		-- disables default vim syntax highlighting for performance
		additional_vim_regex_highlighting = false
	},

	indent = {
		enable = true		-- enables auto-indentation
	},

	autopairs = {
		enable = true		-- enables autopairs support
	},

	rainbow = {
		enable = true, 	-- enables raibow brackets
		disable = { "" },	-- list of languages for which rainbow is diabled
		extended_mode = true,	-- colors any delimitter
		max_file_lines = nil,	-- enables plugin for any amount of line
	},
}
