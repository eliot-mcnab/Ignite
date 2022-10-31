-- TODO: handle class logic sharing by Inheritance. Inheritance should be
-- implemented as the ability to pass an existing table to a class 
-- constructor, and have that class constructor add that class's fields to the
-- existing table isntead of creating a new instance table. This however
-- requires a rework of how class constructors are handled: to allow this, 
-- class constructors will have to be specified as an argument to the
-- Class.new() function.
-- ex: 
-- Component = Class.new {
-- 		private = {
-- 			...
-- 		},
-- 		public = {
-- 			...
-- 		},
-- 		constructor = function(self)
--			...
--			return self
-- 		end
-- }

-- handles class implementation in tables
local Class = {
	__error = {
		not_a_class = 'Class instance requires a class table to be created' ..
			'but normal table was passed instead',
		class_change = 'Cannot change class after type' ..
			'after it has been initialised',
		not_a_name = 'Incorrect value, Class name must be a string',
		illegal_nil = 'value cannot be nil',
		not_a_field = 'Class field must be a string',
		not_a_field_type = 'Invalid field type. Valid type are: ' ..
			'"string", "number", "function", "boolean", "table"' ..
			'or a class tale'
	}
}

-- creates a new class
-- @return new class table with __class and __error fields
function Class.new()
	-- represents a class
	local class_table = {
		__error = {}
	}

	-- used to more easily add errors to a class
	function class_table.add_error(...)
		for key, value in pairs(...) do
			class_table.__error[key] = value
		end
	end

	-- adds public field to class
	class_table.__public = {}

	-- adds class public field
	-- @param field (string): public field to add to the class
	-- @param [default_value] (any): default field value used when creating a new
	-- class instance
	function class_table.add_public(field, default_value)
		-- makes sure function arguments are valid
		assert(type(field) == 'string', Class.__error.not_a_field)

		-- adds private field to class
		class_table.__public[field] = default_value
	end

	-- adds private table to class
	class_table.__private = {}

	-- adds class private fields
	-- @param field (string): private field to add to the class
	-- @param [default_value] (any): default field value used when creating a new
	-- class instance
	function class_table.add_private(field, default_value)
		-- makes sure function arguments are valid
		assert(type(field) == 'string', Class.__error.not_a_field)

		-- adds private field to class
		class_table.__private[field] = default_value
	end

	-- class constructor
	class_table.new = function () end

	-- returns the class table
	return class_table
end

-- checks if a table is a class table
-- @return true if the table is a class table, false otherwise
function Class.is_class(table)
	-- table must have a __private and __public index to be considered a class
	return table.__private ~= nil and table.__public ~= nil
end

-- creates a new instance of a class
-- @return new instance table
function Class.new_instance(class_table)
	-- ensures that the given table is a class table
	assert(Class.is_class(class_table), Class.__error.not_a_class)

	-- instance table, uses the table passed 
	-- as parameter or creates a new one
	local instance = {}

	-- adds all public fields associated to the parent class and initialises
	-- them at their default value
	for field, default_value in pairs(class_table.__public) do
		instance[field] = default_value
	end

	-- adds private table to class instance
	instance.__private = {}

	-- adds all private fields associated to the parent class and initialises
	-- them at their default value
	for field, default_value in pairs(class_table.__private) do
		instance.__private[field] = default_value
	end

	-- returns the instance table
	return instance
end

-- checks if a table is an instance of a class
-- @return true if the table is an instance of the class, false otherwise
function Class.is_instance(table, class)
	assert(Class.is_class(class), Class.__error.not_a_class)
	assert(table ~= nil, Class.__error.illegal_nil)

	-- if the table has no private table...
	if table.__private == nil then
		-- ...then table cannot be an instance of the class
		return false
	end

	-- makes sure the class instance constains all public class fields
	for field, default_value in pairs(class.__public) do
		-- if table does not constain a class field...
		if table[field] == nil and table[field] ~= default_value then
			-- .. then it is not a class instance
			return false
		end
	end

	-- makes sure the class instance constains all private class fields
	for field, default_value in pairs(class.__private) do
		local table_field = table.__private[field]

		-- if table does not constain a class field...
		if table_field == nil and table_field ~= default_value then
			-- .. then it is not a class instance
			return false
		end
	end

	-- if the table contains all private and public class fields, then it is an
	-- instance of that class
	return true
end

return Class
