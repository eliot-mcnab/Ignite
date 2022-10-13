-- dependencies
local plugins = require 'user.ignite_core.ignite_plugins'
local ignite_ui = require 'user.ignite_core.ignite_ui'

-- makes sure that legendary is loaded
if not plugins.legendary then
	return
end

-- mapping options
local mapping_opts = {
	noremap = true,	-- defines mapping type and avoid recursive mappings
	silent = true	-- does not display output associated to inputing command
}

-- mapping modes
local NORMAL = "n"
local VISUAL = "v"
local TERMINAL = 't'

-- disables default mappings
vim.cmd [[
	let g:NERDCreateDefaultMappings = 0
	let g:move_map_keys = 0 
	let g:normal_move_option = 0 
]]

-- sets leader key
vim.g.mapleader = '<Space>'

-- setting up legendary
plugins.legendary.setup({

	-- ignores in-built keybindings
	include_builtin = false,

	-- initialises keymaps
	keymaps = {
		-- ====================================================================
		-- 								NORMAL MODE 
		-- ====================================================================

		-- WINDOW RESIZING

		-- horizontal
		{
			'<C-S-Right>',
			':vertical resize +2<CR>',
			description = '[UI] Expands window horizontally',
			mode = { NORMAL },
			opts = mapping_opts
		},
		{
			'<C-S-Left>',
			':vertical resize -2<CR>',
			description = '[UI] Shrinks window horizontally',
			mode = { NORMAL },
			opts = mapping_opts
		},
		-- vertical
		{
			'<C-S-Up>',
			':resize -2<CR>',
			description = '[UI] Shrinks window vertically',
			mode = { NORMAL },
			opts = mapping_opts
		},
		{
			'<C-S-Down>',
			':resize +2<CR>',
			description = '[UI] Expands window vertically',
			mode = { NORMAL },
			opts = mapping_opts
		},

		-- WINDOW NAVIGATION

		-- move to right window
		{
			'<C-Right>',
			'<Cmd>wincmd l<CR>',
			description = '[NAV] Moves cursor to right window',
			mode = { NORMAL, TERMINAL },
			opts = mapping_opts
		},
		-- move to left window
		{
			'<C-Left>',
			'<Cmd>wincmd h<CR>',
			description = '[NAV] Moves cursor ot the left window',
			mode = { NORMAL, TERMINAL },
			opts = mapping_opts
		},
		-- move to the upper window
		{
			'<C-Up>',
			'<Cmd>wincmd k<CR>',
			description = '[NAV] Moves cursor to the top window',
			mode = { NORMAL, TERMINAL },
			opts = mapping_opts
		},
		-- move to the lower window
		{
			'<C-Down>',
			'<Cmd>wincmd j<CR>',
			description = '[NAV] Moves cursor to the bottom window',
			mode = { NORMAL, TERMINAL },
			opts = mapping_opts
		},

		-- TAB NAVIGATION

		-- next tab
		{
			'<A-Right>',
			':BufferNext<CR>',
			description = '[TAB] Switches to the next tab',
			mode = { NORMAL },
			opts = mapping_opts
		},
		-- previous tab
		{
			'<A-Left>',
			':BufferPrevious<CR>',
			description = '[TAB] Switches to the previous tab',
			mode = { NORMAL },
			opts = mapping_opts
		},
		-- reorder to next tab
		{
			'<A->>',
			':BufferMoveNext<CR>',
			description = '[TAB] Moves the current tab in place of the next',
			mode = { NORMAL },
			opts = mapping_opts
		},
		-- reorder to previous tab
		{
			'<A-<>',
			':BufferMovePrevious<CR>',
			description = '[TAB] Moves the current tab in place of the previous',
			mode = { NORMAL },
			opts = mapping_opts
		},
		-- goto tab at position...
		{
			'<A-&>',
			':BufferGoto 1<CR>',
			description = '[TAB] Goes to the 1st tab',
			mode = { NORMAL },
			opts = mapping_opts
		},
		{
			'<A-é>',
			':BufferGoto 2<CR>',
			description = '[TAB] Goes to the 2nd tab',
			mode = { NORMAL },
			opts = mapping_opts
		},
		{
			'<A-">',
			':BufferGoto 3<CR>',
			description = '[TAB] Goes to the 3rd tab',
			mode = { NORMAL },
			opts = mapping_opts
		},
		{
			'<A-\'>',
			':BufferGoto 4<CR>',
			description = '[TAB] Goes to the 4th tab',
			mode = { NORMAL },
			opts = mapping_opts
		},
		{
			'<A-(>',
			':BufferGoto 5<CR>',
			description = '[TAB] Goes to the 5th tab',
			mode = { NORMAL },
			opts = mapping_opts
		},
		{
			'<A-->',
			':BufferGoto 6<CR>',
			description = '[TAB] Goes to the 6th tab',
			mode = { NORMAL },
			opts = mapping_opts
		},
		{
			'<A-è>',
			':BufferGoto 7<CR>',
			description = '[TAB] Goes to the 7th tab',
			mode = { NORMAL },
			opts = mapping_opts
		},
		{
			'<A-_>',
			':BufferGoto 8<CR>',
			description = '[TAB] Goes to the 8th tab',
			mode = { NORMAL },
			opts = mapping_opts
		},
		{
			'<A-ç>',
			':BufferGoto 9<CR>',
			description = '[TAB] Goes to the 9th tab',
			mode = { NORMAL },
			opts = mapping_opts
		},
		-- pin tab
		{
			'<A-p>',
			':BufferPin<CR>',
			description = '[TAB] Pins the current tab',
			mode = { NORMAL },
			opts = mapping_opts
		},
		-- close tab
		{
			'<C-e>',
			function()
				-- saves the current buffer before closing it
				vim.cmd('w')
				vim.cmd('BufferClose')

				-- gets the new buffer
				local cur_buff = vim.api.nvim_eval('expand("%:t")')

				-- if there are no used buffers left...
				if cur_buff == "" then
					-- ...exits vim
					vim.cmd('qa')
				end
			end,
			description = '[TAB] Closes the current tab',
			mode = { NORMAL },
			opts = mapping_opts
		},

		-- POPUP WINDOWS

		-- markdown preview
		{
			'<C-g>',
			':Glow<CR>',
			description = '[PREVIEW] Renders markdown file in a floating window',
			mode = { NORMAL },
			opts = mapping_opts
		},
		-- file search
		{
			'<C-f>',
			':Telescope find_files<CR>',
			description = '[FIND] Search for specific files',
			mode = { NORMAL },
			opts = mapping_opts
		},
		-- media search
		{
			'<C-f>m',
			':Telescope media_files<CR>',
			description = '[FIND] Search for specific media files',
			mode = { NORMAL },
			opts = mapping_opts
		},
		-- font glyph search
		{
			'<C-f>f',
			':Telescope glyph<CR>',
			description = '[FIND]  BETA: Search for specific font glyphs',
			mode = { NORMAL },
			opts = mapping_opts
		},
		-- colorscheme toggling
		{
			'<C-f>c',
			':Telescope colorscheme<CR>',
			description = '[FIND] Search for a specific colorscheme'
		},
		-- command search
		{
			'<A-l>',
			':Legendary<CR>',
			description = '[FIND] Opens Legendary command explorer',
			mode = { NORMAL },
			opts = mapping_opts
		},

		-- FILE EXPLORER

		-- toggle file tree
		{
			'<C-t>t',
			function ()
				ignite_ui.toggle_component(Component.TREE)
			end,
			description = '[TREE] Toggles file tree',
			mode = { NORMAL },
			opts = mapping_opts
		},
		-- opens file tree
		{
			'<C-t>o',
			':NvimTreeOpen<CR>',
			description = '[TREE] Open file tree',
			mode = { NORMAL },
			opts = mapping_opts
		},
		-- closes file tree
		{
			'<C-t>e',
			':NvimTreeClose<CR>',
			description = '[TREE] Closes file tree',
			mode = { NORMAL },
			opts = mapping_opts
		},
		-- collapses file tree
		{
			'<C-t>c',
			':NvimTreeCollapse<CR>',
			description = '[TREE] Recursively collapses file tree',
			mode = { NORMAL },
			opts = mapping_opts
		},
		-- refreshes file tree
		{
			'<C-t>r',
			':NvimTreeRefresh<CR>',
			description = '[TREE] Refreshes file tree',
			mode = { NORMAL },
			opts = mapping_opts
		},

		-- TERMINAL

		-- open terminal
		{
			[[<C-\>]],
			function ()
				ignite_ui.toggle_component(Component.TERMINAL)
			end,
			description = '[TERM] Opens a new terminal',
			mode = { NORMAL },
			opts = mapping_opts
		},

		-- escape terminal
		{
			[[<esc>]],
			[[<C-\><C-n>]],
			description = '[TERM] Exits current terminal',
			mode = { TERMINAL },
			opts = mapping_opts
		},

		-- LSP

		-- lsp menu
		{
			'<C-m>l',
			':Trouble document_diagnostics<CR>',
			description = '[LSP] Open LSP menu',
			mode = { NORMAL },
			opts = mapping_opts
		},
		-- goes to symbol declaration
		{
			'<C-g>d',
			'<cmd> lua vim.lsp.buf.declaration()<CR>',
			description =
				'[LSP] Goes to the declaration of the symbol under the cursor',
			opts = mapping_opts
		},
		-- goes to symbol definition
		{
			'<C-g>D',
			'<cmd> lua vim.lsp.buf.definition()<CR>',
			description =
				'[LSP] Goes to the definition of the symbol under the cursor',
			opts = mapping_opts
		},
		-- hovers over symbol
		{
			'<C-l>h',
			'<cmd> lua vim.lsp.buf.hover()<CR>',
			description =
				'[LSP] Displays hover information' ..
				'about the symbol under the cursor',
			opts = mapping_opts
		},
		-- lists all implementation
		{
			'<C-l>i',
			'<cmd> lua vim.lsp.buf.implementation()<CR>',
			description =
				'[LSP] Lists all implementations' ..
				'of the symbol under the cursor',
			opts = mapping_opts
		},
		-- lists all references
		{
			'<C-l>R',
			'<cmd> lua vim.lsp.buf.references()<CR>',
			description =
				'[LSP] Lists all the references' ..
				'to the symbol under the cursor',
			opts = mapping_opts
		},
		-- rename symbol
		{
			'<C-l>r',
			'<cmd> lua vim.lsp.buf.rename()<CR>',
			description =
				'[LSP] Renames all the occurences' ..
				'of the symbol under the cursor',
			opts = mapping_opts
		},
		-- signature help
		{
			'<C-l>s',
			'<cmd> lua vim.lsp.buf.signature_help()<CR>',
			description =
				'[LSP] Desiplays signature information' ..
				'about the symbol under the cursor'
		},

		-- DAP

		-- TODO: update command descriptions

		-- continue debugging
		{
			'<F5>',
			'<cmd>lua require("dap").continue()<CR>',
			description = '[DAP] Starts or resumes application debugging'
		},
		-- step over
		{
			'<CR>',
			'<cmd>lua require("dap").step_over()<CR>',
			description = '[DAP] Moves along one step in debug execution'
		},
		-- step into
		{
			'<C-s>',
			'<cmd>lua require("dap").step_into()<CR>',
			description = '[DAP] Steps into the functions under the cursor'
		},
		-- step out
		{
			'<C-o>',
			'<cmd>lua require("dap").step_out()<CR>',
			description = '[DAP] Steps out of the current functions'
		},
		-- toggle breakpoint
		{
			'<C-b>',
			'<cmd>lua require("dap").toggle_breakpoint()<CR>',
			description = '[DAP] Toggles breakpoint for the current line'
		},
		-- set breakpoint
		--{
			--'<C-B>',
			--'<cmd>lua require("dap").set_breakpoint(vim.fn.input' ..
				--'("Breakpoint condition: "))<CR>',
			--description = '[DAP] sets breakpoint for current line'
		--},

		-- ====================================================================
		-- 									VISUAL MODE
		-- ====================================================================	

		-- BETTER PASTING

		-- does not yank highlighted text when pasting onto it
		{
			'p',
			'_dP',
			description = '[EDIT] Pastes the contents of the system clipboard',
			mode = { VISUAL },
			opts = mapping_opts
		},

		-- BETTER INDENTATION

		-- does not leave visual mode on each indenting
		{
			'>',
			'>gv',
			description = '[EDIT] Indents the selection to the right',
			mode = { VISUAL },
			opts = mapping_opts
		},
		{
			'<',
			'<gv',
			description = '[EDIT] Indents the selection to the left',
			mode = { VISUAL },
			opts = mapping_opts
		},

		-- BETTER COMMENTING

		-- toggle comment
		{
			'<C-c>',
			'<Plug>NERDCommenterToggle',
			description = '[EDIT] Toggles the comment state of the selection',
			mode = { VISUAL },
			opts = mapping_opts
		},

		-- LINE MOVEMENT

		-- move current block up
		{
			'<C-Up>',
			'<Plug>MoveBlockUp',
			description = '[EDIT] Moves selected text up a line',
			mode = { VISUAL },
			opts = mapping_opts
		},
		-- move current block down
		{
			'<C-Down>',
			'<Plug>MoveBlockDown',
			description = '[EDIT] Moves selected text down a line',
			mode = { VISUAL },
			opts = mapping_opts
		},
	},

	-- initialises commands
	commands = {

	},

	-- initialises autocommands
	autocommands = {

	},
})
