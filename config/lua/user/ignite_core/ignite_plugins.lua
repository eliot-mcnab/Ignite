-- dependencies
local DeQueue = require 'user.ignite_core.data_structures.dequeue'

-- stores all plugin tables used by Ignite
local plugins = {}

-- stores all plugins that could not be loaded
plugins.not_loaded = DeQueue.new {}

-- Attemps to require a plugin
-- @return plugin table or nil if require failed
local function require_plugin(plugin_name)
	-- protected plugin loading
	local plugin_loaded, plugin = pcall(require, plugin_name)
	-- if plugin could not be loaded...
	if not plugin_loaded then
		-- adds it to DeQueue of unsuccessfully loaded plugins
		DeQueue.push_tail(plugins.not_loaded, plugin_name)

		return nil
	else
		return plugin
	end
end

-- tries to load all plugins
plugins.barbar = require_plugin('bufferline')
plugins.battery = require_plugin('battery')
plugins.bufferline = {
	base = require_plugin('bufferline'),
	api = require_plugin('bufferline.api')
}
plugins.catppuccin = {
	base = require_plugin('catppuccin'),
	palettes = require_plugin('catppuccin.palettes')
}
plugins.ccc = require_plugin('ccc')
plugins.cmp = {
	base = require_plugin('cmp'),
	lsp = require_plugin('cmp_nvim_lsp')
}
plugins.dap = require_plugin('dap')
plugins.dap_ui = require_plugin('dapui')
plugins.dressing = require_plugin('dressing')
plugins.fidget = require_plugin('fidget')
plugins.gitsigns = require_plugin('gitsigns')
plugins.glow = require_plugin('glow')
plugins.impatient = require_plugin('impatient')
plugins.indent_blankline = require_plugin('indent_blankline')
plugins.legendary = require_plugin('legendary')
plugins.lightbulb = require_plugin('nvim-lightbulb')
plugins.lsp_colors = require_plugin('lsp-colors')
plugins.lspconfig = require_plugin('lspconfig')
plugins.lsp_signature = require_plugin('lsp_signature')
plugins.lualine = require_plugin('lualine')
plugins.luasnip = require_plugin('luasnip')
plugins.mason = {
	base = require_plugin('mason'),
	lspconfig = require_plugin('mason-lspconfig')
}
plugins.nvim_autopairs = require_plugin('nvim-autopairs')
plugins.notify = require_plugin('notify')
plugins.nvim_tree = {
	base = require_plugin('nvim-tree'),
	events = require_plugin('nvim-tree.events'),
	view = require_plugin('nvim-tree.view')
}
plugins.scrollbar = require_plugin('scrollbar')
plugins.symbols_outline = require_plugin('symbols-outline')
plugins.treesitter = require_plugin('nvim-treesitter')
plugins.web_devicons = require_plugin('nvim-web-devicons')
plugins.packer = require_plugin('packer')
plugins.plenary = require_plugin('plenary')
plugins.startup = require_plugin('startup')
plugins.telescope = require_plugin('telescope')
plugins.toggleterm = {
	base = require_plugin('toggleterm'),
	terminal = require_plugin('toggleterm.terminal')
}
plugins.trouble = require_plugin('trouble')

return plugins
