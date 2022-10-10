-- dependencies
local Class = require 'user.ignite_core.ignite_classes'

-- Implementation of a single array DeQueue in Lua
local DeQueue = Class.new()

DeQueue.add_error {
	not_a_dequeue = 'table is not a DeQueue but is treated as such',
	empty_dequeue = 'could not retrieve value from DeQueue, DeQueue is empty',
	invalid_size = 'DeQueue max size must be a number',
	max_size_reached = 'could not add value to DeQueue, max size reached'
}

-- utility function for printing a DeQueue, called by the metatable __tostring
local function dequeue_print(dequeue)
	-- gets the index of the last element in the DeQueue
	local last = dequeue.__private.last
	-- gets the index of the first element in the DeQueue
	local first = dequeue.__private.first

	local empty_tail, empty_head

	-- if the dequeue tail is empty...
	if dequeue[last] == nil then
		-- ... moves on to the next element
		last = last + 1
		-- ...saves the state of the tail
		empty_tail = true
	end
	-- if the dequeue head is empty...
	if dequeue[first] == nil then
		-- moves on to the previous element
		first = first - 1
		-- saves the state of the head
		empty_head = true
	end

	-- if both the head and the tail are empty...
	if empty_tail and empty_head then
		-- ... DeQueue is empty
		return '{}'
	end

	-- buids a string of all elements in the DeQueue
	local dequeue_string = '{'

	-- for every element in the dequeue...
	for i = last, first -  1, 1 do
		-- ... adds the current element to the previous element
		dequeue_string = dequeue_string .. tostring(dequeue[i]) .. ', '
	end

	-- adds the first element at the head of the DeQueue
	dequeue_string = dequeue_string .. tostring(dequeue[first]) .. '}'

	-- returns the final string
	return dequeue_string
end

-- DeQueue constructor
-- @param (elements): elements to add to the head of the DeQueue
-- @return (DeQueue): new DeQueue instance
DeQueue.new = function (elements)
	-- creates new instance
	local dequeue_table = Class.new_instance(DeQueue)

	-- adds private fields
	dequeue_table.add_private {
		first = -1,
		last = 0,
		max_size = nil
	}

	-- for every element...
  	for _, element in ipairs(elements) do
		-- ...updates the size of the head
		dequeue_table.__private.first = dequeue_table.__private.first + 1
		-- ...adds given elements to the dequeue
		dequeue_table[dequeue_table.__private.first] = element
	end

	-- creates the metatable
	local dequeue_mt = {}

	-- overrides tostring method
	dequeue_mt.__tostring = dequeue_print

	-- applies the metatable
	setmetatable(dequeue_table, dequeue_mt)

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
function DeQueue.size(dequeue)
	-- if the DeQueue is empty...
	if DeQueue.is_empty(dequeue) then
		-- ...then it has a size of 0
		return 0
	end

	-- calculate the size of the DeQueue
	local size = dequeue.__private.first - dequeue.__private.last

	-- returns the size of the DeQueue
	return size + 1
end

-- gets the maximum size of a dequeue
-- @param dequeue (DeQueue): the DeQueue to get the size of
-- @return (number): the max size of the DeQueue
function DeQueue.get_max_size(dequeue)
	-- makes sure that the given table is a DeQueue
	assert(Class.is_instance(dequeue, DeQueue), DeQueue.__error.not_a_dequeue)

	-- gets the DeQueue's max size
	return dequeue.__private.max_size
end

-- sets the maximum size of a dequeue
-- @param dequeue (DeQueue): the DeQueue to set the size of
-- @param max_size (number): the max size of the DeQueue
function DeQueue.set_max_size(dequeue, max_size)
	-- makes sure that the given table is a DeQueue
	assert(Class.is_instance(dequeue, DeQueue), DeQueue.__error.not_a_dequeue)
	-- makes sure that max_size is a number
	assert(type(max_size) == 'number', DeQueue.__error.invalid_size)

	-- sets the DeQueue's max size
	dequeue.__private.max_size = max_size
end

-- adds an element at the top of the head of a DeQueue
-- @param dequeue (DeQueue): the dequeue to add the element to
-- @param element (any): the element to add to the DeQueue
function DeQueue.push_head(dequeue, element)
	-- makes sure that the given value is a table
	assert(Class.is_instance(dequeue, DeQueue), DeQueue.__error.not_a_dequeue)

	-- if max size was set...
	if dequeue.__private.max_size then
		-- ...makes sure that there is space left in the DeQueue
		local size = dequeue.__private.first - dequeue.__private.last

		assert(
 			size < dequeue.__private.max_size,
			DeQueue.__error.max_size_reached
		)
	end

	-- increment the index of the first element at the head of the DeQueue
	dequeue.__private.first = dequeue.__private.first + 1

	-- adds element at the head of the DeQueue
	dequeue[dequeue.__private.first] = element
end

-- adds an element at the top of the tail of a DeQueue
-- @param dequeue (DeQueue): the dequeue to add the element to
-- @param element (any): the element to add to the DeQueue
function DeQueue.push_tail(dequeue, element)
	-- makes sure that the given value is a table
	assert(Class.is_instance(dequeue, DeQueue), DeQueue.__error.not_a_dequeue)

	-- if max size was set...
	if dequeue.__private.max_size then
		-- ...makes sure that there is space left in the DeQueue
		local size = dequeue.__private.first - dequeue.__private.last

		assert(
 			size < dequeue.__private.max_size,
			DeQueue.__error.max_size_reached
		)
	end

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

	-- frees up space for garbage collection
	dequeue[dequeue.__private.first] = nil

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

	-- fress up space for garbage collection
	dequeue[dequeue.__private.last] = nil

	-- moves to the next element at the tail of the DeQueue
	-- error handling is already done in DeQueue.peek_tail
	-- so we do not have to worry about the DeQueue being empty
	dequeue.__private.last = dequeue.__private.last + 1

	-- returns the element if the DeQueue is not empty
	return element
end

return DeQueue
