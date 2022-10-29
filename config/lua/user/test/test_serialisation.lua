-- ============================================================================
-- 								SERIALISATION TEST
-- ============================================================================

-- dependencies
local ignite_serialiser = require 'user.ignite_core.ignite_serialiser'
local ignite_filesystem = require 'user.ignite_core.ignite_filesystem'

local test_serialisation = {}

function test_serialisation.run()
	local table = {
		hi = {
			there = {
				no = 2,
				yes = 3
			},
			yolo = 4,
			where = "nope"
		}
	}

	ignite_serialiser.serialise(
		table,
		ignite_filesystem.Paths.config .. '/test.lua',
		'test'
	)
end

return test_serialisation
