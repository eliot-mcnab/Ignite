-- gets path to home
local home = os.getenv('HOME')
-- determines path to Ignite from path to home
local ignite_path = home .. '/.config/ignite'
local ignite_path_config = ignite_path .. '/config'

-- adds Ignite path to vim's runtimepaths
if not vim.tbl_contains(vim.opt.runtimepath:get(), ignite_path_config) then
	vim.opt.runtimepath:append(ignite_path_config)
end

-- saves ignite path
require('user.ignite_core.ignite_filesystem').save_location(ignite_path)

-- style-related setup
local style = require 'user.ignite_core.ignite_style'
style.setup_all {
	theme = 'catppuccin'
}

require 'user.plugins'
require 'user.options'
require 'user.lsp'
require 'user.dap'
require 'user.linting'

-- checks for errors
local errors = require 'user.ignite_core.ignite_errors'
errors.check_all()

-- UI setup
local ui = require 'user.ignite_core.ignite_ui'
ui.setup()

-- Testing
local debug = false
if debug then
	require 'user.test'
end

-- disables vim-prosesstion auto-loading
vim.cmd [[let g:prosession_on_startup = 0]]
