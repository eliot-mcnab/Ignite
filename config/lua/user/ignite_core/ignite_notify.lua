-- dependencies
local Class = require 'user.ignite_core.ignite_classes'
local Dequeue = require 'user.ignite_core.data_structures.dequeue'
local Notif = require 'user.ignite_core.data_structures.notification'
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
ignite_notify.notif_queue = Dequeue.new(1, 2, 3)
Dequeue.set_max_size(
	ignite_notify.notif_queue,
	MAX_NOTIF_VISIBLE + MAX_NOTIF_PENDING
)

--local classes = '{'
--local count = 0

--for class_id, _ in pairs(ignite_notify.notif_queue.__class.__class_id) do
	--classes = classes .. tostring(class_id) .. ', '
	--count = count + 1
--end
--classes = classes .. '}'

-- adds new notification to the queue and displays it if possible
-- @param notif (Notification): notification to display
--function ignite_notify.notify(notif)

--end

local first = Dequeue.peek_head(ignite_notify.notif_queue)

plugins.notify.notify(tostring(first), 'error')

return ignite_notify
