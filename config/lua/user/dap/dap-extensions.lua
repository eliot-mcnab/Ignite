-- makes sure that dap plugin is loaded
local dap_loaded, dap = pcall(require, 'dap')
if not dap_loaded then
	return
end

-- makes sure that dap-ui plugin is loaded
local dap_ui_loaded, dap_ui = pcall(require, 'dap-ui')
if not dap_ui_loaded then
	return
end

-- makes sure that dap virtual text is loaded
local dap_vtext_loaded, dap_vtext = pcall(require, 'nvim-dap-virtual-text')
if not dap_vtext_loaded then
	return
end

local M = {}

M.setup = function ()
	-- dap virtual text setup
	dap_vtext.setup {
		enabled = true,
		enabled_commands = true,
		highlight_changed_variables = true,    -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
		highlight_new_as_changed = false,      -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
		show_stop_reason = true,               -- show stop reason when stopped for exceptions
		commented = false,                     -- prefix virtual text with comment string
		only_first_definition = true,          -- only show virtual text at first definition (if there are multiple)
		all_references = false,                -- show virtual text on all all references of the variable (not only definitions)
		filter_references_pattern = '<module', -- filter references (not definitions) pattern when all_references is activated (Lua gmatch pattern, default filters out Python modules)
		-- experimental features:
		virt_text_pos = 'eol',                 -- position of virtual text, see `:h nvim_buf_set_extmark()`
		all_frames = false,                    -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
		virt_lines = false,                    -- show virtual lines instead of virtual text (will flicker!)
		virt_text_win_col = nil                -- position the virtual text at a fixed window column (starting from the first text column) ,
	}

	-- dap ui setup
	dap_ui.setup {
		icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
		mappings = {
		-- Use a table to apply multiple mappings
			expand = { "<CR>", "<2-LeftMouse>" },
			open = "o",
			remove = "d",
			edit = "e",
			repl = "r",
			toggle = "t",
		},
		-- Expand lines larger than the window
		-- Requires >= 0.7
		expand_lines = vim.fn.has("nvim-0.7"),
		-- Layouts define sections of the screen to place windows.
		-- The position can be "left", "right", "top" or "bottom".
		-- The size specifies the height/width depending on position. It can be an Int
		-- or a Float. Integer specifies height/width directly (i.e. 20 lines/columns) while
		-- Float value specifies percentage (i.e. 0.3 - 30% of available lines/columns)
		-- Elements are the elements shown in the layout (in order).
		-- Layouts are opened in order so that earlier layouts take priority in window sizing.
		layouts = {
			{
				elements = {
				-- Elements can be strings or table with id and size keys.
					{ id = "scopes", size = 0.25 },
					"breakpoints",
					"stacks",
					"watches",
				},
				size = 40, -- 40 columns
				position = "left",
			},
			{
				elements = {
					"repl",
					"console",
				},
				size = 0.25, -- 25% of total lines
				position = "bottom",
			},
		},
		controls = {
			-- Requires Neovim nightly (or 0.8 when released)
			enabled = true,
			-- Display controls in this element
			element = "repl",
			icons = {
				pause = "",
				play = "",
				step_into = "",
				step_over = "",
				step_out = "",
				step_back = "",
				run_last = "↻",
				terminate = "□",
			},
		},
		floating = {
			max_height = nil, -- These can be integers or a float between 0 and 1.
			max_width = nil, -- Floats will be treated as percentage of your screen.
			border = "single", -- Border style. Can be "single", "double" or "rounded"
			mappings = {
				close = { "q", "<Esc>" },
			},
		},
		windows = { indent = 1 },
		render = {
			max_type_length = nil, -- Can be integer or nil.
			max_value_lines = 100, -- Can be integer or nil.
		}
	}

	-- dap ui integration with dap
	dap.listeners.after.event_initialized['dapui_config'] = function ()
		dap_ui.open()
	end
	dap.listeners.before.event_terminated["dapui_config"] = function ()
		dap_ui.close()
	end
	dap.listeners.before.event_exited["dapui_config"] = function ()
		dap_ui.close()
	end
end

return M
