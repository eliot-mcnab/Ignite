-- dependencies
local class = require('user.ignite_core.ignite_classes')

-- simple implementation of an array queue in Lua
local Queue = class.new('queue')

Queue.add_error {
	not_a_queue = 'table is not a queue but is treated as such',
	empty_queue = 'could not pull head of queue, queue is empty',
	invalid_max_size = 'queue max size must be a number',
	no_space = 'could not add element, max queue size reached'
}

-- creates a new instance of the Queue class
-- @return new Queue instance
function Queue.new(...)
	-- creates new instance of the Queue class
	local queue = class.instance(Queue)

	-- creates private fields
	queue.add_private {
		first = 0,		-- queue head inde
		max_size = nil	-- max queue size, uncapped by default
	}

	-- adds all elements to the queue and updates the index of the head
	for index, value in ipairs(...) do
		queue[index] = value
		queue.__private.first = queue.__private.first + 1
	end

	-- returns the new instance
	return queue
end

-- sets a queue's max size
function Queue.set_max_size(queue, max_size)
	-- makes sure that queue is an instance of the queue class
	assert(class.is_instance(queue, Queue), Queue.__error.not_a_queue)
	-- makes sure that max_size is a number
	assert(type(max_size) == 'number', Queue.__error.invalid_max_size)

	-- sets the queue's max size
	queue.__private.max_size = max_size
end

-- checks if the queue's max size has not been reached yet
-- @return true if the queue has space left, false otherwise
function Queue.has_space_left(queue)
	-- makes sure that queue is an instance of the queue class
	assert(class.is_instance(queue, Queue), Queue.__error.not_a_queue)

	-- checks if there is still space left in the queue
	return queue.__private.first ~= queue.__private.max_size
end

-- adds element at the head of the queue
function Queue.push(queue, element)
	-- makes sure that the queue has enough space left
	assert(queue.has_space_left(queue), Queue.__error.no_space_left)

	-- updates index of head
	queue.__private.first = queue.__private.first + 1

	-- adds element to the head of the queue
	queue[queue.__private.first] = element
end

-- gets the element at the head of the queue but does not remove it
-- @return value of the element at the head of the queue
function Queue.peek(queue)
	-- makes sure that queue is an instance of the queue class
	assert(class.is_instance(queue, Queue), Queue.__error.not_a_queue)

	-- returns the value of the first element in the queue
	return queue[queue.__private.first]
end


-- determines the size of a queue
-- @return the size of the queue
function Queue.size(queue)
	-- makes sure that queue is an instance of the queue class
	assert(class.is_instance(queue, Queue), Queue.__error.not_a_queue)

	-- returns the size of the queue
	return queue.__private.first
end

-- determines if a queue is empty
-- @return true if the queue is empty, false otherwise
function Queue.is_empty(queue)
	-- makes sure that queue is an instance of the queue class
	assert(class.is_instance(queue, Queue), Queue.__error.not_a_queue)

	-- determines if the queue is empty
	return queue.__private.first == 0
end

-- gets the element at the head of the queue and removes it from the queue
-- @return value of the element at the head of the queue
function Queue.poll(queue)
	-- makes sure that the queue isn't empty
	assert(not Queue.is_empty(queue), Queue.__error.empty_queue)

	-- gets the element at the head of the queue
	local element = queue[queue.__private.first]
	-- allows for garbage collection
	queue[queue.__private.first] = nil

	-- updates the index of the head
	queue.__private.first = queue.__private.first - 1

	-- returns the value at the head of the queue
	return element
end

return Queue
