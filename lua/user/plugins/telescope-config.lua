-- ensures that telescope was correctly loaded
local telescope_loaded, telescope = pcall(require, 'telescope')
if not telescope_loaded then
	return
end

--telescope.load_extension('fzf')
telescope.load_extension('media_files')
telescope.load_extension('glyph')

-- telescope setup
telescope.setup {
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
		-- preview font gliphs with telescope
		glyph = {
			action = function(glyph)
				-- argument glyph is a table.
				-- {name="", value="", category="", description=""}

				vim.fn.setreg("*", glyph.value)
				print([[Press p or "*p to paste this glyph]] .. glyph.value)

				-- insert glyph when picked
				-- vim.api.nvim_put({ glyph.value }, 'c', false, true)
			end,
		},
	}
}
