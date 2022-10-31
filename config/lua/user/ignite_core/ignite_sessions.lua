-- ============================================================================
--						SESSION MANAGEMENT IN IGNITE
-- ============================================================================

-- dependencies
local ignite_filesystem = require 'user.ignite_core.ignite_filesystem'
local ignite_UI         = require 'user.ignite_core.ignite_ui'
local Class             = require 'user.ignite_core.ignite_classes'

-- handles session creation and loading in Ignite
local ignite_sessions = Class.new()

-- session-realted errors
ignite_sessions.add_error {
	not_a_session_path = 'The given path does not match an Ignite session'
}

-- sets up session options
function ignite_sessions.setup()
	vim.opt['sessionoptions'] = {
		'buffers',
		'curdir',
		'folds',
		'help',
		'resize',
		'tabpages',
		'winsize'
	}
end

-- saves the current ignite session
-- @param [session_path] (string): where to save the resulting Session.vim 
-- file, current directory by default ('./')
function ignite_sessions.save_session(session_path)
	-- default values
	session_path = session_path or './'

	-- makes sure function arguments are valid
	assert(
		type(session_path) == 'string' and vim.fn.isdirectory(session_path) ~= 0,
		ignite_filesystem.__error.not_a_file_path
	)

	-- saves Ignite session
	local cmd = 'mksession! ' .. session_path .. '/Session.vim'
	vim.cmd(cmd)
end

-- loads a specified ignite session
-- @param session_path (string): path to the session to load
function ignite_sessions.load_session(session_path)
	-- makes sure function arguments are valid
	assert(
		type(session_path) == 'string' and string.match(session_path, '.*.vim$'),
		ignite_sessions.__error.not_a_session_path
	)

	-- loads Ignite session
	local cmd = 'source ' .. session_path
	vim.cmd(cmd)
end

return ignite_sessions
