-- remaps plugin keys for vim plugins

-- ============================================================================
--									VISUAL MULTI
-- ============================================================================

vim.api.nvim_set_var('VM_default_mappings', 0)
vim.cmd [[
	let g:VM_maps = {}
	let g:VM_maps["Select Cursor Down"] 	= '<C-Down>'
	let g:VM_maps["Select Cursor Up"]		= '<C-Up>'
	let g:VM_maps['Find Under'] 		= '<C-n>'
	let g:VM_maps['Find Subword Under'] = '<C-n>'
]]
