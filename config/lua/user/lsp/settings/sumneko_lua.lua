-- returns options for sumneko_lua lsp
return {
	settings = {
		Lua = {
			diagnostics = {
				globals = { 'vim' }
			}
		},
		workspace = {
			Library = {
				[vim.fn.expand("$VIMRUNTIME/lua")] = true,
				[vim.fn.stdpath("config") .. "/lua"] = true,
			}
		}
	}
}
