-- ============================================================================
--									IO MODES
-- ============================================================================

-- dependencies
local Class = require 'user.ignite_core.ignite_classes'

-- enum Class representing all lua IO modes
local Io_Mode = Class.new()

-- private fields
Io_Mode.add_private('mode', '')

-- class errors
Io_Mode.add_error {
	not_a_lua_mode = 'Invalid Lua file mode. Valid file modes are: ' ..
		'"r", "w", "a", "r+", "w+" and "a+"',
	not_an_io_mode = 'Table is not an Io_Mode but is treadted as such.' ..
		'Available io_modes are: READ, WRITE, APPEND, ' ..
		'POWER_READ, POWER_WRITE and POWER_APPEND'
}

-- ============================================================================
--								HELPER FUNCTIONS
-- ============================================================================

-- array of lua file modes
local LUA_MODES = {'r', 'w', 'a', 'r+', 'w+', 'a+'}

-- checks if a string is a valid lua file mode
-- @param string (string): the string to check
-- @return (boolean): true if the string is a valid lua file mode, false
-- otherwise
local function is_valid_lua_mode(string)
	-- for every valid lua file mode...
	for _, mode in pairs(LUA_MODES) do
		-- ...if the string matches a mode...
		if string == mode then
			-- ...then it is valid
			return true
		end
	end

	-- if string is not among valid lua modes, returns false
	return false
end

-- private Io_Mode constructor
-- @param lua_mode (string): lua file mode
-- @return (Io_Mode): new Io_Mode object
local function io_mode_new(lua_mode)
	-- makes sure function arguments are valid
	assert(is_valid_lua_mode(lua_mode), Io_Mode.__error.not_a_lua_mode)

	-- creates new class instance
	local new_instance = Class.new_instance(Io_Mode)

	-- sets instance lua mode
	new_instance.__private.mode = lua_mode

	-- returns new instance
	return new_instance
end

-- ============================================================================
--								 ENUM CONSTANTS
-- ============================================================================

-- opens a file in read-only mode
Io_Mode.READ = io_mode_new('r')

-- opens a file in write-only mode, ovewriting any previous file contents
Io_Mode.WRITE = io_mode_new('w')

-- opens a file in write-only mode, conserving any previous file content and
-- appending new data at the end of the file
Io_Mode.APPEND = io_mode_new('a')

-- opens file in read and write mode, ovewriting any previous file contents
Io_Mode.POWER_READ = io_mode_new('r+')

-- opens file in write-only mode, ovewriting any previous fields contents and
-- creating a new file with the correct write permissions if the file did not
-- exist already
Io_Mode.POWER_WRITE = io_mode_new('w+')

-- opens a file in write-only mode, conserving any previous file content and
-- appending new data at the end of the file, creating a new file with the
-- correct write permissions if the file did not exist already
Io_Mode.POWER_APPEND = io_mode_new('a+')

-- ============================================================================
--									CLASS FUNCTIONS
-- ============================================================================

-- converts an Io_Mode to its associated lua mode
-- @param io_mode (Io_Mode): Io_Mode enum constant to convert back to its
-- associated lua file mode string
-- @return (string): lua file mode string corresponding to the given io_mode
-- @see Io_Mode
function Io_Mode.to_lua_mode(io_mode)
	-- makes sure function arguments are valid
	assert(Class.is_instance(io_mode, Io_Mode), Io_Mode.__error.not_an_io_mode)

	-- returns the Io_Mode's associated lua mode
	return io_mode.__private.mode
end

-- io mode -> power variant mappings
local io_mode_to_power_variant = {}
io_mode_to_power_variant[Io_Mode.READ]         = Io_Mode.POWER_READ
io_mode_to_power_variant[Io_Mode.WRITE]        = Io_Mode.POWER_WRITE
io_mode_to_power_variant[Io_Mode.APPEND]       = Io_Mode.POWER_APPEND
io_mode_to_power_variant[Io_Mode.POWER_READ]   = Io_Mode.POWER_READ
io_mode_to_power_variant[Io_Mode.POWER_WRITE]  = Io_Mode.POWER_WRITE
io_mode_to_power_variant[Io_Mode.POWER_APPEND] = Io_Mode.APPEND

-- converts an Io_Mode to its associated power variant 
-- @param io_mode (Io_Mode): the Io_Mode to convert to its power variant. If
-- io_mode is already a power variant then it is directly returned'
function Io_Mode.to_power_variant(io_mode)
	-- makes sure function arguments are valid
	assert(Class.is_instance(io_mode, Io_Mode), Io_Mode.__error.not_an_io_mode)

	-- converts the io_mode to its power variant
	return io_mode_to_power_variant[io_mode]
end

return Io_Mode
