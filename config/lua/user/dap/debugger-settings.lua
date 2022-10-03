-- sets up debuggers for ignite
require('user.dap.settings.c').setup()

-- sets custom signs for nvim-dap

-- breakpoint
vim.fn.sign_define(
	'DapBreakpoint',
	{
		text = '🔴',
		texthl='',
		linehl='',
		numhl=''
	}
)

-- conditional breakpoint
vim.fn.sign_define(
	'DapBreakpointCondition',
	{
		text = '🔵',
		texthl='',
		linehl='',
		numhl=''
	}
)

-- stopped sign (current execution line)
vim.fn.sign_define(
	'DapStopped',
	{
		text = '🔸',
		texthl='',
		linehl='',
		numhl=''
	}
)
