-- makes sure that plugin was correctly loaded
local indent_bl_loaded, indent_bl = pcall(require, 'indent-blankline')
if not indent_bl_loaded then
	return
end

print("here!")

vim.opt.list = true
vim.opt.listchars:append "space:⋅"
vim.opt.listchars:append "eol:↴"

indent_bl.setup {
	space_char_blankline = " ",
    show_current_context = true,
    show_current_context_start = true,
	filetype_exclude = {
		'startup'
	}
}
