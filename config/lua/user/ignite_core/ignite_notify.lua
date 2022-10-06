-- dependencies
local class = require 'user.ignite_core.ignite_classes'
local queue = require 'user.ignite_core.data_structures.queue'
local plugins = require 'user.ignite_core.ignite_plugins'

-- constants
local MAX_NOTIF_VISIBLE = 3	-- maximum number of visible notifications
local MAX_NOTIF_PENDING = 5	-- maximum number of pending notifications

if not plugins.notify then
	return
end

-- queue responsible for holding all of the notifications
local notif_queue = queue.new()
queue.set_max_size(notif_queue, MAX_NOTIF_VISIBLE + MAX_NOTIF_PENDING)

queue.push(notif_queue, 1)

plugins.notify.notify('test message', 'error', {
	title =  'test'
})
