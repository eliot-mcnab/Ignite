-- ============================================================================
--									IO ERRORS
-- ============================================================================

-- dependencies
local Class = require 'user.ignite_core.ignite_classes'

-- enum Class reprensenting all Io_Errors handled by Ignite
local Io_Error = Class.new()

-- Class fields
Io_Error.add_private('error_message', '')

-- Class errors
Io_Error.add_error {
	not_an_error_message = 'Io_Error error message must be a string.',
	not_an_io_error = 'Table is not an Io_Error but is treated as such.'
}

-- ============================================================================
--							 	 HELPER FUNCTIONS
-- ============================================================================

-- private Io_Error constructor
-- @param error_message (string): error message associated to the Io_Error
local function io_error_new(error_message)
	-- makes sure function arguments are valid
	assert(type(error_message) == 'string')

	-- creates new Class instance
	local new_instance = Class.new_instance(Io_Error)

	-- sets private fields
	new_instance.__private.error_message = error_message

	-- returns new instance
	return new_instance
end

-- ============================================================================
--								  ENUM CONSTANTS
-- ============================================================================

Io_Error.NO_ERROR = io_error_new(
	'No error detected.'
)

Io_Error.OPEN_INEXISTANT_FILE = io_error_new(
	'File could not be opened because given path point nowhere.'
)
Io_Error.OPEN_RESTRICTED_FILE = io_error_new(
	'File could not be opened because of permission restrictions.'
)

Io_Error.WRITE_RESTRICTED_FILE = io_error_new(
	'File could not be written to because of permission restrictions.'
)

-- ============================================================================
--								  CLASS METHODS
-- ============================================================================

-- determines if an error occured. This function handles the case of dummy
-- errors such as Io_Error.NO_ERROR instead on relying on the user handling 
-- them manually
-- @param io_error (Io_Error): the error to check.
function Io_Error.error_occured(io_error)
	-- makes sure function arguments are valid
	assert(Class.is_instance(io_error, Io_Error),
		Io_Error.__error.not_an_io_error)

	-- determines if the io_error is a dummy error
	return io_error ~= Io_Error.NO_ERROR
end

return Io_Error
