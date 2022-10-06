-- handles class association with tables
local Class = {
	error = {
		not_a_class = 'Class instance requires a class table to be created' ..
			'but normal table was passed instead',
		class_change = 'Cannot change class after type' ..
			'after it has been initialised'
	}
}

function Class:new(class_name)
	local class_table = {
		class = class_name,
		error = {}
	}

	self.__newindex = function (table, key, value)
		if key == 'class' then
			error(Class.error.class_change)
		else
			table[key] = value
		end
	end
	self.__index = class_table

	function self.add_error(...)
		for key, value in ipairs({...}) do
			class_table.error[key] = value
		end
	end

	return self
end

function Class.is_class(table)
	return(table.class ~= nil)
end

function Class.instance(class_table)
	assert(Class.is_class(class_table), Class.error.not_a_class)

	local instance = {
		class = class_table.class,
		__private = {},
		-- __protected = {}
	}

	function instance.private(...)
		for key, value in ipairs({...}) do
			instance.__private[key] = value
		end
	end

	return instance
end

function Class.is_instance(class, instance)
	assert(Class.is_class(class), Class.error.not_a_class)
	return instance.class == class.class
end

return Class
