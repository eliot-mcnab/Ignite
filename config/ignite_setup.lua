-- gets path to home
local home = os.getenv ( 'HOME' )
-- determines path to Ignite from path to home
local ignite_path = home .. '/.config/ignite/config'

-- adds Ignite path to vim's runtimepaths
if not vim.tbl_contains(vim.opt.runtimepath:get(), ignite_path) then
  vim.opt.runtimepath:append(ignite_path)
end

require 'user.plugins'
require 'user.ignite_core'
require 'user.options'
require 'user.lsp'
require 'user.dap'

-- checks for errors
local errors = require 'user.ignite_core.ignite_errors'
errors.check_all()

-- style-related setup
local style = require 'user.ignite_core.ignite_style'
style.setup_all()

-- UI setup
local ui = require 'user.ignite_core.ignite_ui'
ui.setup()

-- Testing
local debug = false
if debug then
	require 'user.ignite_core.data_structures.test'
end

-- disables vim-prosesstion auto-loading
vim.cmd [[let g:prosession_on_startup = 0]]
