-- dependencies
local plugins = require 'user.ignite_core.ignite_plugins'

-- makes sure that mason is loaded
if not plugins.mason.base then
	return
end

-- makes sure that mason-lspconfig is loaded
if not plugins.mason.lspconfig then
	return
end

local M = {}

-- Loading order matters !!!
-- 1) mason
-- 2) mason-lspconfig
-- 3) lspconfig
M.setup = function()
	-- mason setup
	plugins.mason.base.setup {

	}

	-- mason-lspconfig setup
	plugins.mason.lspconfig.setup {

	}
end

return M
