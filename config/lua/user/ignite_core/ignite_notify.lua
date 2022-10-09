-- dependencies
local Class = require 'user.ignite_core.ignite_classes'
local Dequeue = require 'user.ignite_core.data_structures.dequeue'
local Notif = require 'user.ignite_core.data_structures.notification'
local plugins = require 'user.ignite_core.ignite_plugins'

-- constants
local MAX_NOTIF_VISIBLE = 1		-- maximum number of visible notifications
local MAX_NOTIF_PENDING = 1	-- maximum number of pending notifications

-- makes sure that notify is loaded
if not plugins.notify then
	return
end

-- ============================================================================
--							      	SETUP
-- ============================================================================

-- notification handling for the Ignite API
local ignite_notify = {}

-- stores all notifications
ignite_notify.notif_queue = Dequeue.new {}

-- number of currently visible notifications
ignite_notify.notif_vis_count = 0

-- sets max notification count
Dequeue.set_max_size(
	ignite_notify.notif_queue,
	-- +1 accounts for discarded notifications display
	MAX_NOTIF_PENDING + 1
)

-- ============================================================================
--							   	HELPER FUNCTIONS
-- ============================================================================

-- helper function used to display a notification
-- @param notif (Notification): the Notification to display
local function notify(notif)
	-- notification type
	local level = Notif.Type.to_log_level(notif.type)
	-- notification title
	local title = notif.title
	-- notification message
	local message = notif.message

	-- displays the notification asynchroneously
	--plugins.notifiy.notify(message, type, {title = title})
	plugins.plenary.async.run(function ()
		-- displays notification
		plugins.notify.async(message, level, {title = title}).events.close()
		-- once notification has closed, if more notifications are queing...
		if not Dequeue.is_empty(ignite_notify.notif_queue) then
			-- ...siplays the next notification
			notify(Dequeue.poll_head(ignite_notify.notif_queue))
		end
	end)
end

-- ============================================================================
--							      IGNITE NOTIFY
-- ============================================================================

-- determines if new notification will be displayed
-- @return (Notification.State): state of the notification after trying to
-- display it. Available states are:
-- - VISIBLE: notification can be displayed
-- - PENDING: not enough space for notification to be displayed, it will be
-- added waiting queue
-- - DISCARDED: max number of notifications reached, no new notification may be
-- displayed
function ignite_notify.can_notify()
	-- determines if notification can be displayed
	local is_visible = ignite_notify.notif_vis_count < MAX_NOTIF_VISIBLE

	-- notification can be displayed
	if is_visible then
		return Notif.State.VISIBLE
	end

	-- determines if notification can be added to pending
	local notif_pending_count = Dequeue.size(ignite_notify.notif_queue)
	local is_pending = notif_pending_count < MAX_NOTIF_PENDING

	-- notification can be added to pending
	if is_pending then
		return Notif.State.PENDING
	end

	-- notification will be discarded
	return Notif.State.DISCARDED
end

-- adds notification to notification queue and tries to display it.
--
-- If notification cannot be displayed it will wait for previous notification
-- to finish displaying.
--
-- If max number of notifications in waiting has been reached, notification
-- will be discarded and added to the count of discarded notifications. A final
-- notification will be displayed once all other notifications have finished
-- displaying, logging the number of discarded notifications.
--
-- Warning: notifications are no longguer accepte once max count has been
-- reached, even if new space is made available thereafter!
--
-- @param notification (Notification): the Notification to display
-- @return (Notification.State): the state of the Notification (if it could be
-- displayed)
function ignite_notify.notify(notif)
	-- makes sure that the given variable is a notification
	assert(Class.is_instance(notif, Notif), Notif.__error.not_a_notif)

	-- gets the state of the notification
	local state = ignite_notify.can_notify()

	-- if the notification can be displayed...
	if state == Notif.State.VISIBLE then
		-- ...updates the number of visible notifications
		ignite_notify.notif_vis_count = ignite_notify.notif_vis_count + 1
		-- ...displays the notification
		notify(notif)
		-- goes to end of function
		return state
	end

	-- if the notification cannot be displayed but can be queued...
	if state == Notif.State.PENDING then
		-- adds the notification to the bottom of the notification queue
		Dequeue.push_tail(ignite_notify.notif_queue, notif)
		-- goes to the end of the function
		return state
	end

	-- max number of notifications reached
	return state
end

--plugins.notify.notify(tostring(ignite_notify.notif_queue), 'error')
local notif_1 = Notif.new(
	'Ignite THIS!',
	'Test',
	Notif.Type.INFO
)

local notif_2 = Notif.new(
	'BLOAT, BLOAT, BLOAT',
	'Error',
	Notif.Type.ERROR
)

ignite_notify.notify(notif_1)
ignite_notify.notify(notif_2)

return ignite_notify
