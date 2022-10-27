-- ============================================================================
-- 							NORMINETTE LINTER SETUP
-- ============================================================================

-- dependencies
local plugins = require 'user.ignite_core.ignite_plugins'

-- makes sure null-ls is correctly loaded
if not plugins.null_ls then
	return
end

-- shorthands
local helpers = require("null-ls.helpers")
local methods = require("null-ls.methods")

local DIAGNOSTICS_ON_SAVE = methods.internal.DIAGNOSTICS_ON_SAVE

-- sets up norminette linter
local norminette = {
    name = 'norminette',
    meta = {
        url = 'https://github.com/42School/norminette',
        description = 'terrible C linter for 42 schools',
        notes = {
            '\'norminette\' will only be run when files are saved to disk',
        },
    },
    method = DIAGNOSTICS_ON_SAVE,
    filetypes = { 'c' },
    generator = helpers.generator_factory {
		command = 'norminette',
		args = {
			'-d',
			'$FILENAME'
		},
		format = 'line',
		from_stderr = true,
		on_output = helpers.diagnostics.from_pattern(
			-- '.+(%d+):(%d+):(.*)$',
			"[^%d]+(%d+)[^%d]+(%d+)%):[%s]+(.*)$",
			{ "row", "col", "message" }
		)
	}
}

plugins.null_ls.register(norminette)
