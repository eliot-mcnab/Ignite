-- makes sure that notify was properly loaded
local notify_loaded, notify = pcall(require, 'notify')
if not notify_loaded then
	return
end

-- loads all notification strings
local strs = require('user.notifications.notif_str')

local ERROR = vim.log.levels.ERROR

local M = {}

-- ============================================================================
--								ERROR NOTIFICATIONS
-- ============================================================================

-- Notifies user that an error has occured
M.notify_error = function (message, title)
	notify.notify(
		message,
		ERROR,
		{
			title = title
		}
	)
end

M.no_session = function ()
	M.notify_error(
		strs.no_session_found.message,
		strs.no_session_found.title
	)
end

return M
