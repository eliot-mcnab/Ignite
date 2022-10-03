-- makes sure dap plugin was loaded correctly
local dap_loaded, dap = pcall(require, 'dap')
if not dap_loaded then
	print('here')
	return
end

local M = {}

-- gets path to home
local home = os.getenv ( 'HOME' )
-- determines path to Ignite from path to home
local ignite_path = home .. '/.config/ignite/config'
local cppdbg_path = ignite_path
	.. '/lua/user/dap/debuggers/cpptools/extension/debugAdapters/bin/OpenDebugAD7'

M.setup = function ()
	-- sets up c debugger for debugger adapter protocal
	dap.adapters.cppdbg = {
		id = 'cppdbg',
		type = 'executable',
		command = cppdbg_path
	}

	-- c++ debugger
	dap.configurations.cpp = {
		{
			name = "Launch file",
			type = "cppdbg",
			request = "launch",
			program = function()
				return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
			end,
			cwd = '${workspaceFolder}',
			stopAtEntry = true,
		},
		{
			name = 'Attach to gdbserver :1234',
			type = 'cppdbg',
			request = 'launch',
			MIMode = 'gdb',
			miDebuggerServerAddress = 'localhost:1234',
			miDebuggerPath = '/usr/bin/gdb',
			cwd = '${workspaceFolder}',
			program = function()
				return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
			end,
		},
	}

	-- c debugger
	dap.configurations.c = dap.configurations.cpp

	-- rust debugger
	dap.configurations.rust = dap.configurations.cpp
end

return M
