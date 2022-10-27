-- dependencies
local plugins = require 'user.ignite_core.ignite_plugins'

-- makes sure that plugin was correctly loaded
if not plugins.indent_blankline then
	return
end

vim.opt.list = true
vim.opt.listchars:append 'eol:↴'
vim.opt.listchars:append 'nbsp:·'
vim.opt.listchars:append 'trail:·'

plugins.indent_blankline.setup {
	space_char_blankline = " ",
    show_current_context = true,
    show_current_context_start = true,
	ignore_filetype = {
		'startup'
	}
}
