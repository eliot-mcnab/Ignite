local M = {}

-- Determines if a file exists at the given path
M.file_exists = function (file)
	-- tries to rename file to see if it exists
	local ok, err, code = os.rename(file, file)

	-- if write rights were denied, then file exists
	if not ok and code == 13 then
		return true
	end

	-- returns whether or not the file exists (was renamed)
	return ok
end

-- Gets the path to the file executing this function
M.get_local_path = function ()
	local str = debug.getinfo(2, 'S').source:sub(2)
	return str:match('(.*[/\\])')
end

return M
