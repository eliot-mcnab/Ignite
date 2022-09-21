-- ============================================================================
-- 									VIM-MOVE
-- ============================================================================

vim.cmd [[
	let g:move_map_keys = 0

	vmap <C-Down> 	<Plug>MoveBlockDown
	vmap <C-Up>		<Plug>MoveBlockUp
	vmap <C-Left>	<Plug>MoveBlockLeft
	vmap <C-Right>	<Plug>MoveBlockRight

	nmap <C-Down>	<Plug>MoveLineDown
	nmap <C-Up>		<Plug>MoveLineUp
	nmap <C-Left>	<Plug>MoveCharLeft
	nmap <C-Right>	<Plug>MoveCharRight
]]

-- ============================================================================
-- 								NERDCOMMENTER
-- ============================================================================

vim.cmd [[
	map <C-c>	<Plug>NERDCommenterToggle
]]
