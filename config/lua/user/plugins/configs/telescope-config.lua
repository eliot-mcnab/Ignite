-- dependencies
local plugins = require 'user.ignite_core.ignite_plugins'

-- ensures that telescope was correctly loaded
if not plugins.telescope then
	return
end

--telescope.load_extension('fzf')
plugins.telescope.load_extension('media_files')

-- telescope setup
plugins.telescope.setup {
	-- extensions setup
	extensions = {
		-- fuzzy finding performance improvements
		--fzf = {
			--fuzzy = true,					-- false will only do exact matching
			--override_generic_sorter = true,	-- override the generic sorter
			--override_file_sorter = true,	-- override the file sorter
			--case_mode = "smart_case",		-- or "ignore_case" or "respect_case"
											---- the default case_mode is "smart_case"
		--},
		-- preview media files with telescope
		media_files = {
			-- filetypes whitelist
			-- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
			filetypes = {"png", "webp", "jpg", "jpeg"},
			find_cmd = "rg" -- find command (defaults to `fd`)
		},
	}
}
