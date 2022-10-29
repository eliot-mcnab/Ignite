-- ============================================================================
--							IGNITE FILE HANDLER
-- ============================================================================

-- dependencies
local Io_Mode  = require 'user.ignite_core.data_structures.filesystem.io_mode'
local Io_Error = require 'user.ignite_core.data_structures.filesystem.io_error'
local Class    = require 'user.ignite_core.ignite_classes'

-- ============================================================================
--							FILE HANDLING ERRORS
-- ============================================================================

-- Ignite file handler for simple file manipulation
-- (mainly opening and writing to files, reading not yeat implemented till
-- there is an actual need for parsing)
local ignite_filesystem = Class.new()

-- collection of useful filepaths used by Ignite
ignite_filesystem.Paths = {}

-- io errors
ignite_filesystem.add_error {
	not_a_file_path = 'File path must be a string.',
	not_a_file_content = 'File content must be a string.'
}

-- errors shorthand
local ignite_io_errors = ignite_filesystem.__error

-- ============================================================================
--							FILE HANDLING METHODS
-- ============================================================================

-- determines if a file exists at a given path
-- @param file_path (string): path to the file
-- @return (boolean): true if a file already exists at the given path, false
-- otherwise
function ignite_filesystem.exists(file_path)
	-- makes sure function arguments are valid
	assert(type(file_path), ignite_io_errors.not_a_file_path)

	-- tries and open a file at the given path
	local file, _, error_code = io.open(file_path, 'r')

	-- file coule be opened therefore it exists
	if file ~= nil then
		io.close(file)
		return true
	end

	-- permission to open file was denied, therefore it exists
	if error_code == 13 then
		return true
	end

	-- file could not be opened and there was no permission error, 
	-- file does not exists
	return false
end

-- tries to open a file at the given file path
-- @param file_path (string): path to the file to open
-- @param io_mode (Io_Mode): Io_Mode used to open the file
-- @return ({file, Io_Error}): index 1 -> file, nul if file could not be opened
-- index 2 -> IO Error associated to opening the file
function ignite_filesystem.open_file(file_path, io_mode)
	-- makes sure function arguments are valid
	assert(type(file_path) == 'string', ignite_io_errors.not_a_file_path)
	assert(Class.is_instance(io_mode, Io_Mode), Io_Mode.__error.not_an_io_mode)

	-- opens the file
	local lua_mode = Io_Mode.to_lua_mode(io_mode)
	local file, _, error_code = io.open(file_path, lua_mode)

	-- gets the error associated to opening the file, by default, no error is 
	-- detected
	local io_error = Io_Error.NO_ERROR

	-- file could not be opened due to permission
	if file == nil and error_code == 13 then
		io_error = Io_Error.OPEN_RESTRICTED_FILE
	-- file does not exist
	elseif file == nil then
		io_error = Io_Error.OPEN_INEXISTANT_FILE
	end

	-- returns the opened file
	return file, io_error
end

-- writes a string directly to a file, overwriting its content
-- @param file_path (string): path to the file to write to
-- @param content_string (string): content to write to the file
-- @return (Io_Error): Error describing if file could be written to
function ignite_filesystem.write_to_file(file_path, content_string)
	-- makes sure function arguments are valid
	assert(type(file_path) == 'string', ignite_io_errors.not_a_file_path)
	assert(type(content_string) == 'string', ignite_io_errors.not_a_file_content)

	-- opens file at the given path
	local file, io_error = ignite_filesystem.open_file(
		file_path,
		Io_Mode.POWER_WRITE
	)

	-- if error was detected, exits function
	if Io_Error.error_occured(io_error) or file == nil then
		goto function_end
	end

	-- if no error was detected, write to file
	io.output(file)
	io.write(content_string)
	io.close(file)

	::function_end::

	return io_error
end

-- saves ignite location in file system
-- @param ignite_path (string): path to ignite main folder in file system
function ignite_filesystem.save_location(ignite_path)
	-- makes sure function arguments are valid
	assert(type(ignite_path) == 'string', ignite_io_errors.not_a_file_path)

	-- saves file paths
	ignite_filesystem.Paths.root = ignite_path
	ignite_filesystem.Paths.config = ignite_path .. '/config'
end

return ignite_filesystem
