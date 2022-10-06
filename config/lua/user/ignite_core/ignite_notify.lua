-- dependencies
local class = require 'user.ignite_core.ignite_classes'
local queue = require 'user.ignite_core.data_structures.queue'

local MAX_NOTIF_VISIBLE = 3	-- maximum number of visible notifications
local MAX_NOTIF_PENDING = 5	-- maximum number of pending notifications

-- queue responsible for holding all of the notifications
local notif_queue = queue.new()
queue.set_max_size(notif_queue, MAX_NOTIF_VISIBLE + MAX_NOTIF_PENDING)

