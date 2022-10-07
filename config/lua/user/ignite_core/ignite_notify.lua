-- dependencies
local class = require 'user.ignite_core.ignite_classes'
local queue = require 'user.ignite_core.data_structures.queue'
local notif = require 'user.ignite_core.data_structures.notification'
local plugins = require 'user.ignite_core.ignite_plugins'

-- constants
local MAX_NOTIF_VISIBLE = 3	-- maximum number of visible notifications
local MAX_NOTIF_PENDING = 5	-- maximum number of pending notifications

-- makes sure that notify is loaded
if not plugins.notify then
	return
end

-- holds all of the data and functions related to notifications
local ignite_notify = {}

-- queue responsible for holding all of the notifications
ignite_notify.notif_queue = queue.new()
queue.set_max_size(
	ignite_notify.notif_queue,
	MAX_NOTIF_VISIBLE + MAX_NOTIF_PENDING
)

-- adds new notification to the queue and displays it if possible
-- @param notif (Notification): notification to display
function ignite_notify.notify(notif)

end

--plugins.notify.notify('test message', 'error', {
	--title =  tostring('test' == 'test')
--})

return ignite_notify
