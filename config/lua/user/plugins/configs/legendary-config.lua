-- dependencieslege
local plugins = require 'user.ignite_core.ignite_plugins'
local ignite_ui = require 'user.ignite_core.ignite_ui'
local ignite_terminal = require 'user.ignite_core.ignite_terminal'
local Component = require 'user.ignite_core.data_structures.ui.ui_component'

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
vim.g.mapleader = ' '

-- setting up legendary
plugins.legendary.setup({

	-- ignores in-built keybindings
	include_builtin = false,

	-- initialises keymaps
	keymaps = {
		-- ====================================================================
		-- 									WINDOWS
		-- ====================================================================

		-- WINDOW RESIZING

		-- horizontal
		{
			'<C-S-Right>',
			function ()
				plugins.smart_split.resize_right(2)
			end,
			description = '[UI] Expands window horizontally',
			mode = { NORMAL },
			opts = mapping_opts
		},
		{
			'<C-S-Left>',
			function ()
				plugins.smart_split.resize_left(2)
			end,
			description = '[UI] Shrinks window horizontally',
			mode = { NORMAL },
			opts = mapping_opts
		},
		-- vertical
		{
			'<C-S-Up>',
			function ()
				plugins.smart_split.resize_up(2)
			end,
			description = '[UI] Shrinks window vertically',
			mode = { NORMAL },
			opts = mapping_opts
		},
		{
			'<C-S-Down>',
			function ()
				plugins.smart_split.resize_down(2)
			end,
			description = '[UI] Expands window vertically',
			mode = { NORMAL },
			opts = mapping_opts
		},

		-- WINDOW NAVIGATION

		-- move to right window
		{
			'<S-Right>',
			function ()
				plugins.smart_split.move_cursor_right()
			end,
			description = '[NAV] Moves cursor to right window',
			mode = { NORMAL, TERMINAL },
			opts = mapping_opts
		},
		-- move to left window
		{
			'<S-Left>',
			function ()
				plugins.smart_split.move_cursor_left()
			end,
			description = '[NAV] Moves cursor ot the left window',
			mode = { NORMAL, TERMINAL },
			opts = mapping_opts
		},
		-- move to the upper window
		{
			'<S-Up>',
			function ()
				plugins.smart_split.move_cursor_up()
			end,
			description = '[NAV] Moves cursor to the top window',
			mode = { NORMAL, TERMINAL },
			opts = mapping_opts
		},
		-- move to the lower window
		{
			'<S-Down>',
			function ()
				plugins.smart_split.move_cursor_down()
			end,
			description = '[NAV] Moves cursor to the bottom window',
			mode = { NORMAL, TERMINAL },
			opts = mapping_opts
		},

		-- ====================================================================
		-- 									TABS
		-- ====================================================================

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
			'<A-??>',
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
			'<A-??>',
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
			'<A-??>',
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

		-- ====================================================================
		-- 								PREVIEWS
		-- ====================================================================

		-- markdown preview
		{
			'<A-m>',
			':Glow<CR>',
			description = '[PREVIEW] Renders markdown file in a floating window',
			mode = { NORMAL },
			opts = mapping_opts
		},

		-- ====================================================================
		-- 								TELESCOPE
		-- ====================================================================

		-- file search
		{
			'<C-f>f',
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

		-- ====================================================================
		-- 								NVIMTREE 
		-- ====================================================================

		-- toggle file tree
		{
			'<C-t>t',
			function ()
				ignite_ui.toggle_component(Component.FILE_TREE)
			end,
			description = '[TREE] Toggles file tree',
			mode = { NORMAL },
			opts = mapping_opts
		},
		-- toggles symbols tree
		{
			[[<C-s>s]],
			function ()
				ignite_ui.toggle_component(Component.SYMBOLS)
			end,
			description = '[UI] Toggles symbols tree'
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

		-- ====================================================================
		-- 								TERMINAL
		-- ====================================================================

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
			[[<C-e>]],
			[[<C-\><C-n>]],
			description = '[TERM] Exits current terminal',
			mode = { TERMINAL },
			opts = mapping_opts
		},

		-- ====================================================================
		-- 								GIT INTEGRATION
		-- ====================================================================

		-- lazygit terminal integration
		{
			[[<A-g>]],
			function ()
				ignite_terminal.lazygit:toggle()
			end,
			description = '[GIT] Opens a lazygit terminal instance',
			mode = { NORMAL },
			opts = mapping_opts
		},

		-- ====================================================================
		-- 									LSP
		-- ====================================================================

		-- goes to symbol definition
		{
			'<C-l>d',
			'<cmd> lua vim.lsp.buf.definition()<CR>',
			description =
				'[LSP] Goes to the definition of the symbol under the cursor',
			opts = mapping_opts
		},
		-- hovers over symbol
		{
			'<C-l>h',
			':Lspsaga hover_doc<CR>',
			description =
				'[LSP] Displays hover information' ..
				' about the symbol under the cursor',
			opts = mapping_opts
		},
		-- lists all references
		{
			'<C-l>i',
			':Lspsaga lsp_finder<CR>',
			description =
				'[LSP] Lists all references' ..
				' to the symbol under the cursor',
			opts = mapping_opts
		},
		-- rename symbol
		{
			'<C-l>r',
			'<cmd>lua vim.lsp.buf.rename()<CR>',
			description =
				'[LSP] Renames all the occurences' ..
				' of the symbol under the cursor',
			opts = mapping_opts
		},
		-- signature help
		{
			'<C-l>s',
			'<cmd> lua vim.lsp.buf.signature_help()<CR>',
			description =
				'[LSP] Displays signature information' ..
				' about the symbol under the cursor'
		},
		-- code action
		{
			[[<C-l>a]],
			':Lspsaga code_action<CR>',
			description = '[LSP] Selects a code action available' ..
				' at the current cursor position'
		},
		-- jumps to next diagnostic
		{
			[[<C-l>n]],
			':Lspsaga diagnostic_jump_next<CR>',
			description = '[LSP] Jumps to the next lsp diagnostic' ..
				'in the current file'
		},
		-- jumps to previous diagnostic
		{
			[[<C-l>p]],
			':Lspsaga diagnostic_jump_prev<CR>',
			description = '[LSP] Jumps to the previous lsp diagnostic' ..
				'in the current file'
		},

		-- ====================================================================
		-- 									DAP
		-- ====================================================================

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
		-- 									EDITING
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
			{
				n = {'<Plug>(comment_toggle_linewise_current)'},
				v = {'<Plug>(comment_toggle_blockwise_visual)'}
			},
			description = '[EDIT] Toggles the comment state of the selection',
			opts = mapping_opts
		},

		-- LINE MOVEMENT

		-- move current block up
		{
			'<C-Up>',
			[[:MoveBlock(-1)<CR>]],
			description = '[EDIT] Moves selected text up a line',
			mode = { VISUAL },
			opts = mapping_opts
		},
		-- move current block down
		{
			'<C-Down>',
			[[:MoveBlock(1)<CR>]],
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
