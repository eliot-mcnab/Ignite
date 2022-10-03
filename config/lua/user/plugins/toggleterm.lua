-- makes sure that toggleterm is correctly loaded
local toggleterm_loaded, toggleterm = pcall(require, 'toggleterm')
if not toggleterm_loaded then
	return
end

-- toggleterm setup
toggleterm.setup {
	open_mapping = [[<c-\>]]
}
