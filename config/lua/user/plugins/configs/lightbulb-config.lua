-- dependencies
local plugins = require 'user.ignite_core.ignite_plugins'

-- makes sure nvim-lightbulb is loaded
if not plugins.lightbulb then
	return
end

-- nvim-lightbulb setup
plugins.lightbulb.setup = {
	autocmd = {
		enabled = true
	}
}
