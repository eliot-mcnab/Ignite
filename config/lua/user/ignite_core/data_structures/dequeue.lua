-- dependencies
local class = require 'user.ignite_core.ignite_classes'
local Queue = require 'user.ignite_core.data_structures.queue'

-- simple DeQueue implementation in Lua
local DeQueue = class.inherit(Queue)

DeQueue.add_error {
	not_a_dequeue = 'tale is not a DeQueue but is treated as such'
}

-- creates a new instance of the DeQueue class
-- @param ... : elements to add to the head of the DeQueue
-- @return new DeQueue instance
DeQueue.new = function (...)
	-- creates new instance of the Queue class
	local queue_table = class.new_instance(DeQueue)

	-- creates private fields
	queue_table.add_private {
		last = 0,		-- queue tail index
		max_size = nil,	-- max queue size, uncapped by default
		tail = {}		-- stores elements in the tail of the dequeue
	}

	-- adds all elements to the head of the DeQueue 
	-- and updates the index of the head
	for index, value in ipairs({...}) do
		queue_table[index] = value
		queue_table.__private.first = queue_table.__private.first + 1
	end

	-- returns the new instance
	return queue_table
end

-- calculates the size of a DeQueue
-- @param dequeue (DeQueue): the DeQueue
-- @return the total size of the DeQueue
function DeQueue.size(dequeue)
	-- makes sure that the given table is a dequeue
	assert(class.is_instance(dequeue, DeQueue), DeQueue.__error.not_a_dequeue)

	-- calculates the size of the dequeue
	return dequeue.__private.first + dequeue.__private.last
end

-- determines if the DeQueue has space left
-- @param dequeue (DeQueue): the DeQueue
-- @return true if the DeQueue has space left, false otherwise
function DeQueue.has_space_left(dequeue)
	-- determines the size of the DeQueue
	local size = DeQueue.size(dequeue)

	-- determines if the DeQueue has space left
	return size < dequeue.__private.max_size
end

return DeQueue
