-- dependencies
local plugins = require 'user.ignite_core.ignite_plugins'

-- makes sure catppuccin is loaded
if not plugins.catppuccin.base then
	return
end

-- set catppuccin style
vim.g.catppuccin_flavour = 'macchiato'

-- catppuccin setup
plugins.catppuccin.base.setup {
	-- enables plugins integration
	integrations = {
		barbar = true,
		gitsigns = true,
		indent_blankline = {
			enabled = true,
			colored_indent_levels = false,
		},
		mason = true,
		cmp = true,
		dap = {
			enabled = true,
			enable_ui = true
		},
		native_lsp = {
			enabled = true,
			virtual_text = {
				errors = { "italic" },
				hints = { "italic" },
				warnings = { "italic" },
				information = { "italic" },
			},
			underlines = {
				errors = { "underline" },
				hints = { "underline" },
				warnings = { "underline" },
				information = { "underline" },
			},
		},
		notify = true,
		nvimtree = true,
		treesitter = true,
		ts_rainbow = true,
		telescope = true,
		lsp_trouble = true
	}
}
