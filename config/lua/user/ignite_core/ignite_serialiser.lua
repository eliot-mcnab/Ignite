-- ============================================================================
-- 							   LUA TABLE SERIALISATION
-- ============================================================================

-- dependencies
local Class = require 'user.ignite_core.ignite_classes'
local ignite_filesystem = require 'user.ignite_core.ignite_filesystem'

-- handles lua table serialisation for Ignite
local ignite_serialiser = Class.new()

-- serialisation related errors
ignite_serialiser.add_error {
	not_a_table = 'Cannot serialise a non-table value.',
	not_a_var_name = 'Name of variable to serialise must be a string.',
	not_serialised = 'Serialisation must be reprensented by a string.'
}

-- ============================================================================
-- 								   HELPER FUNCTIONS
-- ============================================================================

-- generates serialisation header
-- @return (string) serialisation header to which the rest of the serialisation
-- string is appended
--
-- example header:
-- ============================================================================
-- 				THIS FILE WAS SERIALISED USING IGNITE SERIALISER
-- 				
-- 				serialisation date:	29-10-2022
-- 				serialisation time:	16:25
-- ============================================================================
local function serialise_header()
	-- gets the current time
	local os_date = os.date('*t')

	local bar = '--' .. '===========================================' ..
		'=================================\n'

	local indent = '-- 				'

	local title = indent ..
		'THIS FILE WAS SERIALISED USING IGNITE SERIALISER\n'

	local spacer = indent .. '\n'

	-- date display
	local date_seperator = '-'
	local date = indent .. 'serialisation date: ' ..
		os_date.day   .. date_seperator ..
		os_date.month .. date_seperator ..
		os_date.year  .. '\n'

	-- time display
	local time_seperator = ':'
	local time = indent .. 'serialisation time: ' ..
		os_date.hour .. time_seperator ..
		os_date.min  .. time_seperator ..
		os_date.sec  .. '\n'

	-- header
	local header = bar .. title .. spacer .. date .. time .. bar .. '\n'

	return header
end

-- begins serialisation by initialising variable
-- @param serialised_old (string): serialisation so far
-- @param var_name (string): the name used to serialise the variable
-- @return (string): string used to serialise variable
local function serialise_var_name(serialised_old, var_name)
	-- makes sure function arguments are valid
	assert(type(serialised_old) == 'string',
		ignite_serialiser.__error.not_serialised)
	assert(type(var_name) == 'string',
		ignite_serialiser.__error.not_a_var_name)

	local serialised_new = serialised_old .. 'local ' .. var_name .. ' = '

	return serialised_new
end

-- ends serialisation by returning serialised table
--- @param serialised_old (string): serialisation so far
--- @param var_name (string): the name used to serialise the variable. MUST be
-- the same as used with serialise_var_name(1)
-- @return (string): string used to serialise variable
local function serialise_var_return(serialised_old, var_name)
	-- makes sure function arguments are valid
	assert(type(serialised_old) == 'string',
		ignite_serialiser.__error.not_serialised)
	assert(type(var_name) == 'string',
		ignite_serialiser.__error.not_a_var_name)

	local serialised_new = serialised_old .. 'return ' .. var_name

	return serialised_new
end

-- ============================================================================
-- 									SERIALISATION
-- ============================================================================

-- serialises a lua table into a .lua file in a human-readable format 
-- which can be required once Ignite is next run. 
-- Note that since lua files are loaded only once this can only be
-- used to store data BETWEEN sessions, not write and updating existing data.
-- For that purpouse, and for performance reasons, you should prioritise
-- updating existing tables and only serialising them on program exit
-- @param table (table): the lua table to serialise
-- @param file_path (string): the path to which the table will be serialised
-- @param [var_name] (string): name used to serialise variable, M by default
-- @return (Io_Error): error describing wheter table could be serialized
function ignite_serialiser.serialise(table, file_path, var_name)
	-- default values
	var_name = var_name or 'M'

	-- makes sure function arguments are valid
	assert(type(table) == 'table',
		ignite_serialiser.__error.not_a_table)
	assert(type(file_path) == 'string',
		ignite_filesystem.__error.not_a_file_path)
	assert(type(var_name) == 'string',
		ignite_serialiser.__error.not_a_var_name)

	-- keeps track of the current indent level
	local indent_level = 0

	-- serialised string
	local serialised

	-- adds serialisation header
	serialised = serialise_header()

	-- starts serialising variable
	serialised = serialise_var_name(serialised, var_name)

	-- writes the serialised data
 	local io_error = ignite_filesystem.write_to_file(file_path, serialised)

	-- returns error reprensenting whether serialisation was successful
	return io_error
end

return ignite_serialiser
