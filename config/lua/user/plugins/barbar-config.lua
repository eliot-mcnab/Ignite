-- makes sure that barbar is loaded
local barbar_loaded, barbar = pcall(require, 'bufferline')
if not barbar_loaded then
	return
end

-- barbar setup
barbar.setup {
	-- sets icon characters
	icon_separator_active = '▎',
	icon_separator_inactive = '▎',
	icon_close_tab = '',
	icon_close_tab_modified = '●',
	icon_pinned = '車',
}
