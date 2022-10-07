-- dependencies
local class = require 'user.ignite_core.ignite_classes'
local queue = require 'user.ignite_core.data_structures.queue'

-- simple DeQueue implementation in Lua
local DeQueue = class.inherit(queue, 'DeQueue')

-- creates a new instance of the DeQueue class
-- @param ... : elements to add to the head of the DeQueue
-- @return new DeQueue instance
function DeQueue.new(...)
	-- creates new instance of the Queue class
	local queue = class.new_instance(DeQueue)

	-- creates private fields
	queue.add_private {
		first = 0,		-- queue head index
		last = 0,		-- queue tail index
		max_size = nil	-- max queue size, uncapped by default
	}

	-- adds all elements to the head of the DeQueue 
	-- and updates the index of the head
	for index, value in ipairs({...}) do
		queue[index] = value
		queue.__private.first = queue.__private.first + 1
	end

	-- returns the new instance
	return queue
end

function DeQueue.size(dequeue)
	-- 
end

-- 
function DeQueue.has_space_left(dequeue)
	
end

return DeQueue
