-- ============================================================================
-- 								SERIALISATION TEST
-- ============================================================================

-- dependencies
local ignite_serialiser = require 'user.ignite_core.ignite_serialiser'
local ignite_filesystem = require 'user.ignite_core.ignite_filesystem'

local test_serialisation = {}

function test_serialisation.run()
	ignite_serialiser.serialise(
		{},
		ignite_filesystem.config .. '/test.lua',
		'test'
	)
end

return test_serialisation
