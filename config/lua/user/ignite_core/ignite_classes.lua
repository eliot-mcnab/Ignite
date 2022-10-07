-- handles class implementation in tables
local Class = {
	__error = {
		not_a_class = 'Class instance requires a class table to be created' ..
			'but normal table was passed instead',
		class_change = 'Cannot change class after type' ..
			'after it has been initialised',
		not_a_name = 'Incorrect value, Class name must be a string'
	}
}

-- creates a new class
-- @return new class table with __class and __error fields
function Class.new(class_name)
	-- makes sure that class_name is a string
	assert(type(class_name) == 'string', Class.__error.not_a_name)

	-- represents a class
	local class_table = {
		__class_id = {},	-- TODO: replace this by propper hashset implementation
		__error = {}
	}

	-- adds class name to the list of class ids
	class_table.__class_id[class_name] = true

	-- used to more easily add errors to a class
	function class_table.add_error(...)
		for key, value in pairs(...) do
			class_table.__error[key] = value
		end
	end

	-- class constructor
	class_table.new = {}

	-- returns the class table
	return class_table
end

-- creates a new class which inherits all the methods of its parent class
-- @param parent (Class): the parent class
-- @param class_name (string): the name of the child class
-- @return new class which shares the methods of its parent
function Class.inherit(parent, class_name)
	-- makes sure that class_name is a string
	assert(type(class_name) == 'string', Class.__error.not_a_name)
	-- makes sure that parent is a class
	assert(parent.__class_id ~= nil, Class.__error.not_a_class)

	-- creates the child class
	local child = Class.new(class_name)

	-- adds child class id
	child.__class_id[class_name] = true

	-- adds parent class ids
	for class_id, _ in pairs(parent.__class_id) do
		child.__class_id[class_id] = true
	end

	-- creates a metatable for the child class
	local child_mt = {
		__index = parent
	}

	-- sets the metatable
	setmetatable(child, child_mt)

	-- returns the child class
	return child
end

-- checks if a table is a class table
-- @return true if the table is a class table, false otherwise
function Class.is_class(table)
	return(table.__class_id ~= nil)
end

-- checks if a class inherits from another class
-- @param class (Class): the class to check
-- @return (boolean): true if the class is a subclass, false otherwise
function Class.is_subclass(class)
	-- determines the number of class ids stored by the class
	-- a subclass must have more than 1 class id stored
	return #class.__class_id > 1
end

-- creates a new instance of a class
-- @return new instance table
function Class.new_instance(class_table)
	-- ensures that the given table is a class table
	assert(Class.is_class(class_table), Class.__error.not_a_class)
	
	-- instance table, uses the table passed 
	-- as parameter or creates a new one
	local instance = {}

	-- if the class is a subclass...
	if Class.is_subclass(class_table) then
		instance = Class
	end

	instance.__class = class_table	-- reference to class for inheritance checks
	instance.__private = {}			-- private fields

	-- makes it easier to add private fields to an instance
	function instance.add_private(...)
		for key, value in pairs(...) do
			instance.__private[key] = value
		end
	end

	-- returns the instance table
	return instance
end

-- checks if a table is an instance of a class
-- @return true if the table is an instance of the class, false otherwise
function Class.is_instance(instance, class)
	assert(Class.is_class(class), Class.__error.not_a_class)
	--return instance.__class == class.__class_id

	-- for all class ids in the class...
	for class_id, _ in pairs(class.__class_id) do
		-- ...if the id is not present in the instance's class...
		if not instance.__class.__class_id[class_id] then
			-- ...returns true
			return false
		end
	end

	-- if all ids are contained, value is an instance of the given class
	return true
end

return Class
