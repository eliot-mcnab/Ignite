-- makes sure nvim tree is loaded
local nvim_tree_loaded, nvim_tree = pcall(require, 'nvim-tree')
if not nvim_tree_loaded then
	return
end

-- nvim tree setup
nvim_tree.setup {
	-- disables and replaces netrw
	disable_netrw = true,
	hijack_netrw = true, 
	
	-- keeps cursor on first letter of filename
	hijack_cursor = true,

	-- removes default keymaps
	remove_keymaps = {
		'<C-t>'
	},

	-- sorting mode
	sort_by = "case_sensitive",	

	-- keeps focused file updated
	update_focused_file = {
		enable = true,
		update_cwd = true,
		ignore_list = {},
	},

	-- do not open on the file types
	ignore_ft_on_setup = {
		"startify",
		"dashboard",
		"alpha",
	},

	-- custom diagnostics icons
	diagnostics = {
		enable = true,
			icons = {
				hint = "",
				info = "",
				warning = "",
				error = "",
		},
  	},
}
