-- dependencies
local Class = require 'user.ignite_core.ignite_classes'

-- Implementation of a single array DeQueue in Lua
local DeQueue = Class.new()

DeQueue.add_error {
	not_a_dequeue = 'table is not a DeQueue but is treated as such',
	empty_dequeue = 'could not retrieve value from DeQueue, DeQueue is empty'
}

-- DeQueue constructor
-- @param (elements): elements to add to the head of the DeQueue
-- @return (DeQueue): new DeQueue instance
DeQueue.new = function (elements)
	local dequeue_table = Class.new_instance(DeQueue)	-- creates new instance

	-- adds private fields
	dequeue_table.add_private {
		first = -1,
		last = 0,
		max_size = nil
	}

	-- for every element...
  	for index, element in ipairs(elements) do
		-- ...adds given elements to the dequeue
		dequeue_table[index] = element
		-- ...updates the size of the head
		dequeue_table.__private.first = dequeue_table.__private.first + 1
	end

	-- returns the new instance
	return dequeue_table
end

-- checks if there are any elements in the head of the DeQueue
-- @param (DeQueue): the DeQueue to check
-- @return (boolean): true if the dequeue's head is empty, false otherwise
function DeQueue.is_head_empty(dequeue)
	-- checks that the table is a DeQueue
	assert(Class.is_instance(dequeue, DeQueue), DeQueue.__error.not_a_dequeue)

	-- index of the first element in the DeQueue's head
	local first = dequeue.__private.first

	-- determines if the the head of the dequeue is empty
	return dequeue[first] == nil
end

-- checks if there are any elements in the tail of the DeQueue
-- @param (DeQueue): the DeQueue to check
-- @return (boolean): true if the DeQueue's tail is empty, false otherwise
function DeQueue.is_tail_empty(dequeue)
	-- checks that the table is a DeQueue
	assert(Class.is_instance(dequeue, DeQueue), DeQueue.__error.not_a_dequeue)

	-- index of the last element in the DeQueue's tail
	local last = dequeue.__private.last

	-- determines if the tail of the dequeue is empty
	return dequeue[last] == nil
end

-- checks if a DeQueue is empty
-- @param dequeue (DeQueue): the DeQueue to check
-- @return (boolean): true if the DeQueue is empty, false otherwise
function DeQueue.is_empty(dequeue)
	return DeQueue.is_head_empty(dequeue) and DeQueue.is_tail_empty(dequeue)
end

-- gets the size of a DeQueue
-- @param dequeue (DeQueue): the DeQueue to get the size of
-- @return (number): the size of the DeQueue
function DeQueue.get_size(dequeue)
	-- if the DeQueue is empty...
	if DeQueue.is_empty(dequeue) then
		-- ...then it has a size of 0
		return 0
	end
	
	-- calculate the size of the DeQueue
	local size = dequeue.__private.first - dequeue.__private.last

	-- returns the size of the DeQueue
	return size
end

-- adds an element at the top of the head of a DeQueue
-- @param dequeue (DeQueue): the dequeue to add the element to
-- @param element (any): the element to add to the DeQueue
function DeQueue.push_head(dequeue, element)
	-- makes sure that the table is a DeQueue
	assert(Class.is_instance(dequeue, DeQueue), DeQueue.__error.not_a_dequeue)

	-- increment the index of the first element at the head of the DeQueue
	dequeue.__private.first = dequeue.__private.first + 1

	-- adds element at the head of the DeQueue
	dequeue[dequeue.__private.first] = element
end

-- adds an element at the top of the tail of a DeQueue
-- @param dequeue (DeQueue): the dequeue to add the element to
-- @param element (any): the element to add to the DeQueue
function DeQueue.push_tail(dequeue, element)
	-- makes sure that the table is a dequeue
	assert(Class.is_instance(dequeue, DeQueue), DeQueue.__error.not_a_dequeue)

	-- decrements the index of the last element at the tail of the DeQueue
	dequeue.__private.last = dequeue.__private.last - 1

	-- adds element to the tail of the DeQueue
	dequeue[dequeue.__private.last] = element
end

-- gets the value of the first element at the head of a DeQueue
-- and does not remove it from the DeQueue
-- @param dequeue (DeQueue): the DeQueue to get the element from
-- @return (any): the element contained in the DeQueue
function DeQueue.peek_head(dequeue)
	-- makes sure that the given table is a DeQueue
	assert(Class.is_instance(dequeue, DeQueue), DeQueue.__error.not_a_dequeue)

	-- gets the first element at the head of the DeQueue
	local element = dequeue[dequeue.__private.first]

	-- makes sure that the dequeue is not empty
	assert(element ~= nil, DeQueue.__error.empty_dequeue)

	-- returns the element if the DeQueue is not empty
	return element
end

-- gets the value of the last element at the tail of a DeQueue
-- and does not remove it from the DeQueue
-- @param dequeue (DeQueue): the DeQueue to get the element from
-- @return (any): the element contained in the DeQueue
function DeQueue.peek_tail(dequeue)
	-- makes sure that the given table is a DeQueue
	assert(Class.is_instance(dequeue, DeQueue), DeQueue.__error.not_a_dequeue)

	-- get the last element at the tail of the DeQueue
	local element = dequeue[dequeue.__private.last]
	
	-- makes sure that the dequeue is not empty
	assert(element ~= nil, DeQueue.__error.empty_dequeue)

	-- returns the element if the DeQueue is not empty
	return element
end

-- gets the value of the first element at the head of the DeQueue
-- and removes it from the DeQueue
-- @param dequeue (DeQueue): the DeQueue to get the element from
-- @returns (any): the element that was contained in the DeQueue
function DeQueue.poll_head(dequeue)
	-- gest the first element at the head of the DeQueue
	local element = DeQueue.peek_head(dequeue)

	-- moves to the previous element at the head of the DeQueue
	-- error handling is already done in DeQueue.peek_head
	-- so we do not have to worry about the DeQueue being empty
	dequeue.__private.first = dequeue.__private.first - 1

	-- returns the element if the DeQueue is not empty
	return element
end

-- gets the value of the last element at the tail of the DeQueue
-- and removes it from the DeQueue
-- @param dequeue (DeQueue): the DeQueue to get the element from
-- @return (any): the element that was contained in the DeQueue
function DeQueue.poll_tail(dequeue)
	-- gets the last element at the tail of the DeQueue
	local element = DeQueue.peek_tail(dequeue)

	-- moves to the next element at the tail of the DeQueue
	-- error handling is already done in DeQueue.peek_tail
	-- so we do not have to worry about the DeQueue being empty
	dequeue.__private.last = dequeue.__private.last + 1

	-- returns the element if the DeQueue is not empty
	return element
end
