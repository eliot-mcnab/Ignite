-- Utility functions for use inside of ignite

local M = {}

-- ============================================================================
--								HASH UTILITIES
-- ============================================================================

M.hash = {}

-- Lua implementation of Java's hash function for strings
-- @parap offset: index from which ti start hashing the string
-- @return a hash of the given string
M.hash.string = function (to_hash, offset)
	local hash = 0

	for i=offset or 0, #to_hash do
		hash = hash * 31 + string.byte(to_hash, i)
	end

	return hash
end

-- ============================================================================
--								DATA STRUCTURES
-- ============================================================================

--M.Queue

return M
