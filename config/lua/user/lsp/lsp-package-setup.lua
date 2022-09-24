-- makes sure that mason is loaded
local mason_loaded, mason = pcall(require, 'mason')
if not mason_loaded then
	return 
end

-- makes sure that mason-lspconfig is loaded
local mason_lspconf_loaded, mason_lspconf = pcall(require, 'mason-lspconfig')
if not mason_lspconf_loaded then
	return 
end

local M = {}

-- Loading order matters !!!
-- 1) mason
-- 2) mason-lspconfig
-- 3) lspconfig
M.setup = function()
	-- mason setup
	mason.setup {

	}

	-- mason-lspconfig setup
	mason_lspconf.setup {

	}
end

return M
