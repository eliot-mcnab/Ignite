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
local helpers = plugins.null_ls.helpers
local methods = plugins.null_ls.methods

local DIAGNOSTICS_ON_SAVE = methods.internal.DIAGNOSTICS_ON_SAVE

-- adds norminette to builtin diagnostics linters
return helpers.make_builtin({
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
    generator_opts = {
        command = 'norminette',
        args = {
			'-d',
           '$FILENAME',
        },
        from_stderr = true,
        format = "line",
        check_exit_code = function(code)
            return code <= 1
        end,
        on_output = helpers.diagnostics.from_pattern(
			":(%d+):(%d+):(.*)$",
			{ "row", "col", "message" }
		),
    },
    factory = helpers.generator_factory,
})
