-- ============================================================================
-- 									WRITE TEST
-- ============================================================================

-- dependencies
local ignite_filesystem = require 'user.ignite_core.ignite_filesystem'
local ignite_notify     = require 'user.ignite_core.ignite_notify'
local Notification      = require 'user.ignite_core.data_structures.notification'
local Io_Error          = require 'user.ignite_core.data_structures.filesystem.io_error'

local test = {}

function test.run()
	local path = ignite_filesystem.Paths.config .. '/test.txt'
	local contents = 'Hello World'

	ignite_notify.notify(Notification.new(
		path,
		'INFO',
		Notification.Type.WARN
	))

	local io_error = ignite_filesystem.write_to_file(path, contents)

	ignite_notify.notify(Notification.new(
		Io_Error.get_error_message(io_error),
		'DEBUG',
		Notification.Type.ERROR
	))
end

return test
