-- dependencies
local plugins = require 'user.ignite_core.ignite_plugins'

-- list of functions called externally to setup lsp
local M = {}

M.setup = function()
	-- signes used by lsp for diagnostics
	local signs = {
		{ name = "DiagnosticSignError", text = "" },
		{ name = "DiagnosticSignWarn", text = "" },
		{ name = "DiagnosticSignHint", text = "" },
		{ name = "DiagnosticSignInfo", text = "" },
	}

	-- sets up the signs
	for _, sign in ipairs(signs) do
    	vim.fn.sign_define(sign.name, {
			texthl = sign.name, text = sign.text, numhl = ""
		})
  	end

	-- config for vim diagnostics
	local config = {
		-- show signs
		signs = {
			active = signs,
		},
		update_in_insert = true,
		underline = true,
		severity_sort = true,
		float = {
			focusable = false,
			style = "minimal",
			border = "rounded",
			source = "always",
			header = "",
			prefix = "",
		},
	}

	-- applies config
	vim.diagnostic.config(config)

	-- sets rounded borders for popup windows
	vim.lsp.handlers["textDocument/hover"] =
		vim.lsp.with(vim.lsp.handlers.hover, {
    		border = "rounded",
		})

  	vim.lsp.handlers["textDocument/signatureHelp"] =
		vim.lsp.with(vim.lsp.handlers.signature_help, {
			border = "rounded",
		})
end

-- makes sure that cmp_nvim_lsp is laoded
if not plugins.cmp.lsp then
	return
end

-- used to update cmp to handle lsp
M.capabilities = plugins.cmp.lsp.default_capabilities()
M.capabilities.offsetEncoding = { "utf-16" }

return M
