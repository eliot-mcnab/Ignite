-- ============================================================================
--						SESSION MANAGEMENT IN IGNITE
-- ============================================================================

-- dependencies
local ignite_filesystem = require 'user.ignite_core.ignite_filesystem'
local Class             = require 'user.ignite_core.ignite_classes'

-- handles session creation and loading in Ignite
local ignite_sessions = Class.new()

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

return ignite_sessions
