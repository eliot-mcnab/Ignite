-- Attemps to require a plugin
-- @return plugin table or nil if require failed
local function require_plugin(plugin_name)
	local plugin_loaded, plugin = pcall(require, plugin_name)
	if not plugin_loaded then
		print('Error: could not load plugin ' .. plugin_name)
		return nil
	else
		return plugin
	end
end

return {
	luasnip = require_plugin('luasnip'),
	barbar = require_plugin('bufferline'),
	battery = require_plugin('battery'),
	cmp = require_plugin('cmp'),
	dressing = require_plugin('dressing'),
	gitsigns = require_plugin('gitsigns'),
	glow = require_plugin('glow'),
	impatient = require_plugin('impatient'),
	indent_blankline = require_plugin('indent_blankline'),
	legendary = require_plugin('legendary'),
	lsp_colors = require_plugin('lsp-colors'),
	lualine = require_plugin('lualine'),
	mason_lsp_config = require_plugin('mason-lspconfig'),
	mason = require_plugin('mason'),
	nvim_autopairs = require_plugin('nvim-autopairs'),
	nvim_dap = require_plugin('dap'),
	nvim_dap_ui = require_plugin('dapui'),
	nvim_lspconfig = require_plugin('lspconfig'),
	nvim_notify = require_plugin('notify'),
	nvim_tree = require_plugin('nvim-tree'),
	nvim_treesitter = require_plugin('nvim-treesitter'),
	nvim_web_devicons = require_plugin('nvim-web-devicons'),
	packer = require_plugin('packer'),
	plenary = require_plugin('plenary'),
	startup = require_plugin('startup'),
	telescope = require_plugin('telescope'),
	toggleterm = require_plugin('toggleterm'),
	trouble = require_plugin('trouble')
}
