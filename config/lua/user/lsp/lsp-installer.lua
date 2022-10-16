-- makes mason registry is correctly loaded
local mason_lsp_loaded, mason_lsp = pcall(require, 'mason-lspconfig')
if not mason_lsp_loaded then
	return
end

-- makes sure lspconfig is correctly loaded
local lspconfig_loaded, lspconfig = pcall(require, 'lspconfig')
if not lspconfig_loaded then
	return
end

local M = {}

M.setup = function()
	-- sets up automatic handlers for every server
	mason_lsp.setup_handlers {
		-- default handler
		function(server_name)
			-- global options for every language server
			local opts = {
					capabilities = require('user.lsp.lsp-handlers').capabilities
			}

			-- options specific to sumneko_lua
			if server_name == 'sumneko_lua' then
				local sumneko_opts = require('user.lsp.settings.sumneko_lua')
				opts = vim.tbl_deep_extend('force', sumneko_opts, opts)
			end

			-- sets up the server with the correct options
			lspconfig[server_name].setup(opts)
		end,
	}
end

return M
