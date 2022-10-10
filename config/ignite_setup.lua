-- gets path to home
local home = os.getenv ( 'HOME' )
-- determines path to Ignite from path to home
local ignite_path = home .. '/.config/ignite/config'

-- TODO: refactor code and make this part of a global table which can be 
-- accessed from other files using require

-- adds Ignite path to vim's runtimepaths
if not vim.tbl_contains(vim.opt.runtimepath:get(), ignite_path) then
  vim.opt.runtimepath:append(ignite_path)
end

require 'user.plugins'
require 'user.ignite_core'
require 'user.options'
require 'user.commands'
require 'user.lsp'
require 'user.dap'

-- checks for errors
local errors = require 'user.ignite_core.ignite_errors'
errors.check_all()

-- sets neovim theme

-- COLORCOLUMN 

-- sets color column color (light red)
vim.cmd [[highlight colorcolumn ctermbg = 0 guibg = #ff6666]]

-- filetypes for which to set the colorcolumn
local column_filetypes = {
	'c',
	'lua',
	'markdown'
}

-- autogroup for the followind autocommand
local augroup = vim.api.nvim_create_augroup(
	'colorcolumn_cmds',
	{ clear = true }
)

-- for every filetype specified in column_filetypes...
for _, filetype in ipairs(column_filetypes) do
	-- ...creates an autocommand that will set the colorcolumn
	vim.api.nvim_create_autocmd(
		'FileType',
		{
			pattern = filetype,
			group = augroup,
			desc = 'Enables colorcolumn for ' .. filetype .. ' files',
			command = 'setlocal colorcolumn:80'
		}
	)
end

-- disables vim-prosesstion auto-loading
vim.cmd [[let g:prosession_on_startup = 0]]
