-- dependencies
local notify = require 'user.ignite_core.ignite_notify'
local plugins = require 'user.ignite_core.ignite_plugins'
local Notification = require 'user.ignite_core.data_structures.notification'
local DeQueue = require 'user.ignite_core.data_structures.dequeue'

-- responsible for checking ingite status after configuration has finished
-- loading
local ignite_errors = {}

-- lists all error messages
ignite_errors.error = {
	plugin_load = 'could not load plugin',
	not_a_plugin = 'plugin name must be a string'
}

-- ============================================================================
--							PLUGIN LOADING ERRORS
-- ============================================================================

local notification_title = 'Error Loading Plugin'

-- generates error message for a plugin that could not be loaded
-- @param plugin_name (string): the name of the plugin that could not be loaded
-- @return (string): plugin loading error message
local function plugin_error(plugin_name)
	-- makes sure that plugin_name is a string
	assert(type(plugin_name) == 'string', ignite_errors.error.not_a_plugin)

	-- builds the error message
	return ignite_errors.error.plugin_load .. ' ' .. plugin_name
end

-- checks for errors in plugin loading
-- @return (boolean): true if all plugins were loaded correctly, false 
-- otherwise
function ignite_errors.check_plugins()
	-- determines the number of plugins that could not be loaded
	local not_loaded_size = DeQueue.size(plugins.not_loaded)

	-- determines if all plugins were loaded correctly
	local error_loading = not_loaded_size > 0

	-- if not all plugins could be loaded...
	if error_loading then
		-- ...displays an error notification for each of them
		for _ = 1, not_loaded_size, 1 do
			notify.notify(Notification.new(
				plugin_error(DeQueue.poll_head(plugins.not_loaded)),
				notification_title,
				Notification.Type.ERROR
			))
		end
	end

	-- returns true if loading was sucessful
	return not error_loading
end

-- ============================================================================
--						   	  GENERAL ERROR CHECKING
-- ============================================================================

-- checks for all erros
-- @return (boolean): true if all plugins were loaded without errors, false
-- otherwise
function ignite_errors.check_all()
	-- keeps track of errors
	local no_error = true

	-- checks plugins
	no_error = ignite_errors.check_plugins() and no_error

	-- returns true if no error occured
	return no_error
end

return ignite_errors
