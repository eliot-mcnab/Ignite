-- dependencies
local class = require 'user.ignite_core.ignite_classes'
local dequeue = require 'user.ignite_core.data_structures.dequeue'
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
ignite_notify.notif_queue = dequeue.new()
dequeue.set_max_size(
	ignite_notify.notif_queue,
	MAX_NOTIF_VISIBLE + MAX_NOTIF_PENDING
)

--local classes = '{'

--for class_id, _ in pairs(ignite_notify.notif_queue.__class.__class_id) do
	--classes = classes .. class_id .. ', '
--end
--classes = classes .. '}'

-- adds new notification to the queue and displays it if possible
-- @param notif (Notification): notification to display
--function ignite_notify.notify(notif)

--end

local first = ignite_notify.notif_queue.__private.first

plugins.notify.notify(first, 'error')

return ignite_notify
