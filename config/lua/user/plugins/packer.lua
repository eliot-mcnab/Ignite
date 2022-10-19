-- shorter call to vim.fn
local fn = vim.fn

-- determines install path for packer from root
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"

-- packer repository on github
local packer_repo = "https://github.com/wbthomason/packer.nvim"

-- automatically installs packer
if fn.empty(fn.glob(install_path)) > 0 then

	-- clones packer to the install path
	PACKER_BOOTSTRAP = fn.system {
		"git",
		"clone",
		"--depth",
		"1",
		packer_repo,
		install_path,
	}

	-- notifies user packer had to be installed
	print "Packer has been installed, please restart vim."
	vim.cmd [[packadd packer.nvim]]
end

-- reloads neovim whenever this page is saved (allows to install new plugins)
vim.api.nvim_create_autocmd(
	'BufWritePost',
	{
		pattern = 'plugins.lua',
		group = vim.api.nvim_create_augroup(
			'packer_plugin_install',
			{ clear = true }
		),
		command = 'PackerSync'
	}
)

-- only executes the rest of the file if packer was installed
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

packer.reset()

-- custom packer initialisation
packer.init {
	display = {
		-- opens packer in a floating window with rounded borders
		open_fn = function()
			return require("packer.util").float { border = "rounded" }
		end
	},
	-- Remove disabled or unused plugins without prompting the user
	autoremove = true
}

-- plugins

return packer.startup(function(use)

	-- ========================================================================
	--									SETUP
	-- ========================================================================

	-- allows packer to manage itself
	use 'wbthomason/packer.nvim'
	-- functions library
	use 'nvim-lua/plenary.nvim'
	-- keybindings
	use 'mrjones2014/legendary.nvim'
	-- vim.input replacement
	use 'stevearc/dressing.nvim'
	-- performance
	use 'lewis6991/impatient.nvim'

	-- ========================================================================
	--									 UI
	-- ========================================================================

	-- notifications
	use 'rcarriga/nvim-notify'
	-- icons
	use 'kyazdani42/nvim-web-devicons'
	-- status line
	use {
		'nvim-lualine/lualine.nvim',
		requires = { 'kyazdani42/nvim-web-devicons', opt = true }
	}
	-- power indicator
	use {
		'justinhj/battery.nvim',
		requires = {
			'kyazdani42/nvim-web-devicons',
			'nvim-lua/plenary.nvim'
		}
	}
	-- tabs
	use {
		'romgrk/barbar.nvim',
		requires = { 'kyazdani42/nvim-web-devicons' }
	}
	-- markdown preview
	use	{
		'ellisonleao/glow.nvim',
	}
	-- fuzzy finding
	use {
		'nvim-telescope/telescope.nvim',
		requires = { 'nvim-lua/plenary.nvim' }
	}
	use {
		'nvim-telescope/telescope-fzf-native.nvim',
		run = 'make'
	}
	-- media preview
	use 'nvim-lua/popup.nvim'
	use 'nvim-telescope/telescope-media-files.nvim'
	-- file tree
	use {
		'kyazdani42/nvim-tree.lua',
		requires = {
			'kyazdani42/nvim-web-devicons', -- optional, for file icons
		},
		tag = 'nightly'
	}
	-- terminal
	use 'akinsho/toggleterm.nvim'
	-- startup screen
	use {
		'startup-nvim/startup.nvim',
		requires = {
			'nvim-telescope/telescope.nvim',
			'nvim-lua/plenary.nvim',
		},
	}
	-- scrollbar
	use 'petertriho/nvim-scrollbar'
	-- color support
	use 'uga-rosa/ccc.nvim'
	-- cursor line
	use 'yamatsum/nvim-cursorline'

	-- ========================================================================
	--									EDITING
	-- ========================================================================

	-- easier line moving
	-- automatic paring
	use 'windwp/nvim-autopairs'
	-- autocompletion
	use 'hrsh7th/nvim-cmp'
	use 'hrsh7th/cmp-buffer'
	use 'hrsh7th/cmp-path'
	use 'hrsh7th/cmp-cmdline'
	use 'saadparwaiz1/cmp_luasnip'
	use 'hrsh7th/cmp-nvim-lua'
	-- snippets
	use {
		'L3MON4D3/LuaSnip',
		run = 'make install_jsregexp'
	}
	use 'rafamadriz/friendly-snippets'
	-- commenting
	use 'numToStr/Comment.nvim'
	-- line movement
	use 'fedepujol/move.nvim'
	-- session restoring
	use 'tpope/vim-obsession'
	use 'dhruvasagar/vim-prosession'
	-- navigation
	use 'mrjones2014/smart-splits.nvim'
	-- mutiple cursor support
	use 'mg979/vim-visual-multi'

	-- ========================================================================
	--									LSP
	-- ========================================================================

	-- lsp integration
	use 'hrsh7th/cmp-nvim-lsp'
	use {
		-- lsp package manager
		'williamboman/mason.nvim',
		-- lsp config bridge
		'williamboman/mason-lspconfig.nvim',
		-- lsp config
		'neovim/nvim-lspconfig'
	}
	-- auto theme support for lsp
	use 'folke/lsp-colors.nvim'
	-- error display menu
	use {
		'folke/trouble.nvim',
		requires = 'kyazdani42/nvim-web-devicons',
	}
	-- function signature
	use 'ray-x/lsp_signature.nvim'
	-- clearer code actions
	use 'kosayoda/nvim-lightbulb'
	-- symbols view
	use 'simrat39/symbols-outline.nvim'
	-- lsp server status
	use 'j-hui/fidget.nvim'

	-- ========================================================================
	--									DAP
	-- ========================================================================

	-- dap integration
	use 'mfussenegger/nvim-dap'
	use {
		'rcarriga/nvim-dap-ui',
		requires = 'mfussenegger/nvim-dap'
	}
	use {
		'theHamsta/nvim-dap-virtual-text',
		requires = 'mfussenegger/nvim-dap'
	}
	use {
		'nvim-telescope/telescope-dap.nvim',
		requires = 'mfussenegger/nvim-dap'
	}

	-- ========================================================================
	--									SYNTAX
	-- ========================================================================

	-- syntax highlighting
	use 'nvim-treesitter/nvim-treesitter'
	-- rainbow brackets
	use 'p00f/nvim-ts-rainbow'
	-- better tab visibility
	use 'lukas-reineke/indent-blankline.nvim'

	-- ========================================================================
	--								GIT INTEGRATION
	-- ========================================================================

	-- git signs
	use 'lewis6991/gitsigns.nvim'
	-- diff view
	use 'sindrets/diffview.nvim'

	-- ========================================================================
	--									THEMES
	-- ========================================================================

	use	'morhetz/gruvbox'
	use 'joshdick/onedark.vim'
	use {
		'catppuccin/nvim',
		as = 'catppuccin',
	}
end)
