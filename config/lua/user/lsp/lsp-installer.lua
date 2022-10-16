-- dependencies
local plugins = require 'user.ignite_core.ignite_plugins'

-- makes mason registry is correctly loaded
if not plugins.mason.lspconfig then
	return
end

-- makes sure lspconfig is correctly loaded
if not plugins.lspconfig then
	return
end

local M = {}

M.setup = function()
	-- sets up automatic handlers for every server
	plugins.mason.lspconfig.setup_handlers {
		-- default handler
		function(server_name)
			-- global options for every language server
			local opts = {
				-- nvim-cmp support
				capabilities = require('user.lsp.lsp-handlers').capabilities,

				-- called whenever a LSP server is attached to a buffer
				on_attach = function (_, bufnr)
					plugins.lsp_signature.on_attach({
						bind = true,
						handler_opts = {
							border = 'rounded'
						}
					}, bufnr)
				end
			}

			-- options specific to sumneko_lua
			if server_name == 'sumneko_lua' then
				local sumneko_opts = require('user.lsp.settings.sumneko_lua')
				opts = vim.tbl_deep_extend('force', sumneko_opts, opts)
			end

			-- sets up the server with the correct options
			plugins.lspconfig[server_name].setup(opts)
		end,
	}
end

return M
