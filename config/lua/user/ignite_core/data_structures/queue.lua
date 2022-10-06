-- dependencies
local class = require('user.ignite_core.ignite_classes')

-- simple implementation of an array queue in Lua
local Queue = class:new('queue')

Queue.add_error {
	not_a_queue = 'table is not a queue but is treated as such'
}

function Queue.new(...)
	local queue = class.instance(Queue)
	queue.private {
		first = 0
	}

	for index, value in ipairs({...}) do
		queue[index] = value
		queue.__private.first = queue.__private.first + 1
	end

	return queue
end

function Queue.push(queue, element)
	assert(class.is_instance(Queue, queue), Queue.error.not_a_queue)
end

