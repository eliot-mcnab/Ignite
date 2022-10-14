-- dependencies
local Class = require 'user.ignite_core.ignite_classes'

-- simple circular Stack implementation.
-- Circular_Stack can have a max_size set to it in which case, if the max_size
-- is reached, it will loop around to 0 and overrite previous value.
-- Similarly, when polling a value from a Circular_Stack, if head index reaches
-- -1, the Stack will loop around to it's max_size.
-- This is especially useful when implementing limited history or memory where
-- it is not necessary to inifinitely track all changes. A simple example of
-- this would be a modification history, which would would only store in memory
-- a fixed number of elements before overwritting them.
local Circular_Stack = Class.new()

-- Stack-related errors
Circular_Stack.add_error {
	not_a_stack = 'table is not a Circular_Stack but is considered as such.',
	invalid_elements = 'initial Circular_Stack elements must be a table',
	not_a_max_size = 'Circular_Stack max_size must be a number.',
	invalid_max_size = 'Circular_Stack max_size must be greater than 0.',
	empty_stack = 'cannot retrieve value, Stack is empty.',
	not_an_index = 'Circular_Stack index must be a number.'
}

-- helper function, handles wrapping around stack index
-- @param stack (Circular_Stack): the Stack to use for max_size
-- @param index (number): Stack head index
-- @return (number): Stack head index wrapped around to take max_size into
-- consideration
local function wrap_around(stack, index)
	-- makes sure function arguments are valid
	assert(Class.is_instance(stack, Circular_Stack),
		Circular_Stack.__error.not_a_stack)
	assert(type(index) == 'number', Circular_Stack.__error.not_an_index)

	-- gets the Stack's max size
	local max_size = stack.max_size

	-- if the Stack has no max_size set ...
	if max_size == nil then
		-- ... does not modify the index
		goto function_end
	end

	-- if index is < 0 ...
	if index < 0 then
		-- ... wraps it around to max_size
		return index + max_size
	end

	-- if index is >= max_size
	if index >= max_size then
		-- ... wraps it back to 0
		return index - max_size
	end

	-- if the index does not need updating, returns its original value
	::function_end::
	return index
end

-- helper function to remove excess elements updating Stack max_size to a
-- smaller value. Does not do anything if new max_size is greater than
-- old_max_size
-- @param stack (Circular_Stack): the Stack being resized
-- @param old_max_size (number): the Stack's previous max_size
-- @param new_max_size (number): the Stack's new max_size
-- @see Stack.set_max_size
local function handle_stack_resize(stack, old_max_size, new_max_size)
	-- makes sure function arguments are valid
	assert(Class.is_instance(stack, Circular_Stack),
		Circular_Stack.__error.not_a_stack)
	assert(type(old_max_size) == 'number',
		Circular_Stack.__error.not_a_max_size)
	assert(type(new_max_size) == 'number',
		Circular_Stack.__error.not_a_max_size)

	-- if new max size is NOT smaller than previous max size...
	if old_max_size == nil or old_max_size > new_max_size then
		-- no need to update Stack elements, exits function
		return
	end

	-- for every excess element in the Stack ...
	for i = new_max_size + 1, old_max_size, 1 do
		-- ... removes the element to allow for garbage collection
		stack[i] = nil
	end
end

-- helper function for converting a Circular_Stack to a string
-- @param stack (Circular_Stack): the Stack to convert to a string
-- @return (string): string representation of a Stack
local function stack_to_string(stack)
	-- makes sure function arguments are valid
	assert(Class.is_instance(stack, Circular_Stack),
		Circular_Stack.__error.not_a_stack)

	-- if the Stack is empty ...
	if Circular_Stack.is_empty(stack) then
		-- ... returns default string
		return '{}'
	end

	-- string representation of the stack
	local stack_string = '}'

	-- current index in the Stack
	local index = stack.first

	-- keeps track of whether we have displayed all elements in the Stack
	local elem_count = 0

	-- truncated stack max size to allow for integer operations even if max
	-- size is nil.
	-- -1 replaces max_size if max_size is nil
	local max_size_truncated = stack.max_size or -1

	-- while the previous element in the Stack is not empty ...
	while (stack[wrap_around(stack, index - 1)] ~= nil) and
		elem_count ~= max_size_truncated - 1 do
		-- ... adds the current element to the stack_string
		stack_string = ', ' .. tostring(stack[index]) .. stack_string
		-- moves on to the previous element
		index = wrap_around(stack, index - 1)
		-- keeps track of the number of elements added to the string
		elem_count = elem_count + 1
	end

	-- adds the last element in the Stack to the Stack string
	stack_string = '{' .. tostring(stack[index]) .. stack_string

	-- returns the formatted stack_string
	return stack_string
end

-- stack constructor
-- @param elements (table): elements to add to the Stack upon creation
-- @param max_size (number): the Stack's max size
-- @return a new Stack instance
Circular_Stack.new = function (elements, max_size)
	-- default values
	elements = elements or {}

	-- makes sure function arguments are valid
	assert(type(elements) == 'table', Circular_Stack.__error.invalid_elements)
	assert(max_size == nil or
			type(max_size) == 'number', Circular_Stack.__error.not_a_max_size)
	assert(max_size == nil or
			max_size > 0, Circular_Stack.__error.invalid_max_size)

	-- creates the new Stack instance
	local stack = Class.new_instance(Circular_Stack)

	-- sets the Stack's metatable
	setmetatable(stack, {
		__tostring = stack_to_string
	})

	-- initialises the stack's head index
	stack.first = -1

	-- sets the Stack's max_size
	stack.max_size = max_size

	-- adds all elements to the Stack, in order
	for _, element in ipairs(elements) do
		-- updates the Stack's head index
		stack.first = stack.first + 1
		-- adds the element
		stack[wrap_around(stack, stack.first)] = element
	end

	-- returns the new Stack instance
	return stack
end

-- sets a Stack's max size
-- @param stack (Circular_Stack): the Stack to set the max size of
-- @param max_size (number): the Stack's max size
function Circular_Stack.set_max_size(stack, new_max_size)
	-- makes sure function arguments are valid
	assert(Class.is_instance(stack, Circular_Stack),
		Circular_Stack.__error.not_a_stack)
	assert(type(new_max_size) == 'number',
		Circular_Stack.__error.not_a_max_size)

	-- resizes the Stack
	handle_stack_resize(stack, stack.max_size, new_max_size)

	-- sets the Stack's max_size
	stack.max_size = new_max_size
end

-- gets the max size associated to a Stack
-- @param stack (Circular_Stack): the Stack to get the max size of
-- @return (number): the Stack's max size, or nil if the Stack has no max_size
-- associated to it
function Circular_Stack.get_max_size(stack)
	-- makes sure function arguments are valid
	assert(Class.is_instance(stack, Circular_Stack),
		Circular_Stack.__error.not_a_stack)

	-- gets the Stack's max size
	return stack.max_size
end

-- determines if a Stack is empty
-- @param stack (Circular_Stack): the Stack to check
-- @return (boolean): true if the Stack is empty, false otherwise
function Circular_Stack.is_empty(stack)
	-- makes sure function arguments are valid
	assert(Class.is_instance(stack, Circular_Stack),
		Circular_Stack.__error.not_a_stack)

	-- determines if the Stack is empty
	return stack[stack.first] == nil
end

-- gets the value at the head of the Stack, but does not remove it
-- @param stack (Circular_Stack): the Stack to get the value from
-- @return (any): the value stored at the head of the Stack
function Circular_Stack.peek_head(stack)
	-- makes sure function arguments are valid
	assert(Class.is_instance(stack, Circular_Stack),
		Circular_Stack.__error.not_a_stack)

	-- if Stack is empty ...
	if stack[stack.first] == nil then
		-- ... throws an error
		error(Circular_Stack.__error.empty_stack)
	end

	-- gets the value at the head of the Stack
	return stack[stack.first]
end

-- gets the value at the head ot the Stack and removes it from the Stack
-- @param stack (Circular_Stack): the Stack to get the value from
-- @return (any): the value previously stored at the head of the Stack
function Circular_Stack.poll_head(stack)
	-- gets the value at the head of the Stack
	local head = Circular_Stack.peek_head(stack)

	-- sets the Stack's current head to nil to allow for garbage collection
	stack[stack.first] = nil

	-- updates the Stack's head index
	stack.first = wrap_around(stack, stack.first - 1)

	-- returns the stack's previous head value
	return head
end

-- adds a new value at the head of the Stack
-- @param stack (Circular_Stack): the Stack to add the value to
-- @param value (any): the value to add to the Stack
function Circular_Stack.push_head(stack, value)
	-- makes sure function arguments are valid
	assert(Class.is_instance(stack, Circular_Stack),
		Circular_Stack.__error.not_a_stack)

	-- updates the Stack's head index
	stack.first = wrap_around(stack, stack.first + 1)

	-- adds the new value at the head of the Stack
	stack[stack.first] = value
end

return Circular_Stack
