-- handles class implementation in tables
local Class = {
	error = {
		not_a_class = 'Class instance requires a class table to be created' ..
			'but normal table was passed instead',
		class_change = 'Cannot change class after type' ..
			'after it has been initialised'
	}
}

-- creates a new class
-- @return new class table with __class and __error fields
function Class.new(class_name)
	-- represents a class
	local class_table = {
		__class = class_name,
		__error = {}
	}

	-- used to more easily add errors to a class
	function class_table.add_error(...)
		for key, value in pairs(...) do
			class_table.__error[key] = value
		end
	end

	-- returns the class table
	return class_table
end

-- checks if a table is a class table
-- @return true if the table is a class table, false otherwise
function Class.is_class(table)
	return(table.__class ~= nil)
end

-- creates a new instance of a class
-- @return new instance table
function Class.instance(class_table)
	-- ensures that the given table is a class table
	assert(Class.is_class(class_table), Class.error.not_a_class)

	-- instance table
	local instance = {
		__class = class_table.__class,
		__private = {}
	}

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
function Class.is_instance(class, instance)
	assert(Class.is_class(class), Class.error.not_a_class)
	return instance.class == class.class
end

return Class
