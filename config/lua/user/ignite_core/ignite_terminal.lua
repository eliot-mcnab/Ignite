-- dependencies
local plugin = require 'user.ignite_core.ignite_plugins'
local Terminal = plugin.toggleterm.terminal.Terminal

-- responsible for handling terminals inside of Ignite
local ignite_terminal = {}

-- terminal directions
local DIRECTION_FLOAT = 'float'
local DIRECTION_HORIZONTAL = 'horizontal'

-- lazygit integration
-- code from https://github.com/akinsho/toggleterm.nvim
ignite_terminal.lazygit = Terminal:new {
	cmd = 'lazygit',
	dir = 'git_dir',
	direction = DIRECTION_FLOAT,
	float_opts = {
		border = 'curved'
	},
	-- function to run on opening the terminal
	on_open = function(term)
		vim.cmd [[startinsert!]]
		vim.api.nvim_buf_set_keymap(
			term.bufnr,
			"n",
			"q",
			"<cmd>close<CR>",
			{noremap = true, silent = true})
	end,
	-- function to run on closing the terminal
	on_close = function(_)
		vim.cmd [[startinsert!]]
	end,
	hidden = true
}

-- default terminal displayed in Info Panel UI Slot
-- @see ignite_ui, ui_slots, ui_components
ignite_terminal.default = Terminal:new {
	hidden = true,
	direction = DIRECTION_HORIZONTAL,
	on_open = function ()
		vim.cmd	[[startinsert!]]
	end,
	on_close = function ()
		vim.cmd [[startinsert]]
	end
}

return ignite_terminal
