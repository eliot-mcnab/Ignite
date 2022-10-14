-- dependencies
local plugin = require 'user.ignite_core.ignite_plugins'
local Terminal = plugin.toggleterm.terminal.Terminal

-- responsible for handling terminals inside of Ignite
local ignite_terminal = {}

-- lazygit integration
-- code from https://github.com/akinsho/toggleterm.nvim
ignite_terminal.lazygit = Terminal:new {
	cmd = 'lazygit',
	dir = 'git_dir',
	direction = 'float',
	float_opts = {
		border = 'curved'
	},
	-- function to run on opening the terminal
	on_open = function(term)
		vim.cmd("startinsert!")
		vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
	end,
	-- function to run on closing the terminal
	on_close = function(_)
		vim.cmd("startinsert!")
	end,
	hidden = true
}

return ignite_terminal
