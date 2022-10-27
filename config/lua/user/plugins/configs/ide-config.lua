-- dependencies
local plugins = require 'user.ignite_core.ignite_plugins'

-- makes sure ide is loaded
if not plugins.ide then
	return
end

-- ide setup
plugins.ide.setup {
	--[[ ignore_filetypes = { },
    root_patterns = {".git/"},
    shadow_build = false,
    debug = false,
    project_file = "project.nvide",
    mappings = { },

    quickfix = {
        pos = "bel"
    },

    integrations = {
        dap = {
            enable = false,
            config = { },

            highlights = {
                DapBreakpoint = {ctermbg = 0, fg = "#993939"},
                DapLogPoint   = {ctermbg = 0, fg = "#61afef"},
                DapStopped    = {ctermbg = 0, fg ="#98c379"},
            },

            signs = {
                DapBreakpoint          = { text="", texthl="DapBreakpoint", numhl="DapBreakpoint" },
                DapBreakpointCondition = { text="ﳁ", texthl="DapBreakpoint", numhl="DapBreakpoint" },
                DapBreakpointRejected  = { text="", texthl="DapBreakpoint", numhl= "DapBreakpoint" },
                DapLogPoint            = { text="", texthl="DapLogPoint", numhl= "DapLogPoint" },
                DapStopped             = { text="", texthl="DapStopped", numhl= "DapStopped" },
            }
        },

        dapui = { enable = false },
        git = { enable = false },
    } ]]
	mappings = {
        ["<F5>"] = function(project)
            if project:is_busy() and not project:has_state("debug") then
                return
            end

            project:debug()
        end,

        ["<F7>"] = function(project)
            if project:has_state("debug") then
                project:debug({type = "stepinto"})
            else
                vim.api.nvim_command(":NeoTreeShowToggle")
            end
        end,

        ["<F8>"] = function(project)
            if project:has_state("debug") then
                project:debug({type = "stepover"})
            else
                project:build()
            end
        end,

        ["<C-F5>"] = function(project)
            if not project:has_state("run") then
                project:run()
            end
        end,

        ["<C-F8>"] = function(project)
            project:settings()
        end,

        ["<A-F5>"] = function(project)
            if project:has_state("debug") then
                project:debug({type = "stop"})
            end
        end,

        ["<A-BS>"] = function(project)
            if project:is_busy() and not project:has_state("debug") then
                project:stop()
            end
        end
    },

    integrations = {
        dap = {
            enable = true,

            config = {
                adapters = {
                    codelldb = {
                        type = "server",
                        port = 8990,

                        executable = {
                            command = "<INSERT codelldb PATH>",
                            args = {"--port", "8990"}
                        }
                    }
                }
            }
        },

        dapui = { enable = true },
        git = { enable = true },
    }
}
